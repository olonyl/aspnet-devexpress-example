var DefTitle = 'CONSUMO DE COMBUSTIBLE CONSOLIDADO | SELECCIONAR FILTRO';
var DefTitleProcess = 'CONSUMO DE COMBUSTIBLE CONSOLIDADO | PROCESANDO SOLICITUD';

/*Tool Bar Menu*/
function ItemClickClientEvent(s, e) {

    if (hfId.Get("primeraVisualizacion") && e.item.name != "Filter") {
        e.processOnServer = false;
        ShowWarningDialog('Advertencia', 'No ha seleccionado ningún reporte', function () { popDatos.Show(); });
        return;
    }
    switch (e.item.name) {
        case "GuardarLayout":
            e.processOnServer = false;
            if (hfId.Get("jerarquia") == 'J') {
                pgReportDataConsolidado.PerformCallback(e.item.name);
            } else if (hfId.Get("jerarquia") == 'V') {
                gvReportDataDetallado.PerformCallback(e.item.name);
            }
            break;
        case "PersonalizarGrid":
            e.processOnServer = false;
            if (hfId.Get("jerarquia") == 'J') {
                pgReportDataConsolidado.ChangeCustomizationFieldsVisibility();
            } else if (hfId.Get("jerarquia") == 'V') {
                if (gvReportDataDetallado.IsCustomizationWindowVisible())
                    gvReportDataDetallado.HideCustomizationWindow();
                else
                    gvReportDataDetallado.ShowCustomizationWindow();
            }
            break;
        case "ConfigurarLayout":
            e.processOnServer = false;
            break;
        case "ReiniciarLayout":
            e.processOnServer = false;
            if (hfId.Get("jerarquia") == 'J') {
                pgReportDataConsolidado.PerformCallback(e.item.name);
            } else if (hfId.Get("jerarquia") == 'V') {
                gvReportDataDetallado.PerformCallback(e.item.name);
            }
            break;
        case "Filter":
            e.processOnServer = false;
            popDatos.Show();
            break;
    }
}

function GridEndCallback(s, e) {
    AdjustSize();
    if (s.cp_evento) {
        switch (s.cp_evento) {
            case "GuardarLayout": {
                if (s.cp_estado == 1) {
                    ShowSuccessDialog('Guardar Layout', s.cp_mensaje, function () { });
                }
                else {
                    ShowErrorDialog('Error al Guardar Layout', s.cp_mensaje, function () { });
                }
                break;
            }
            case "ReiniciarLayout": {
                if (s.cp_estado == 1) {
                    pgReportDataConsolidado.PerformCallback('Refrescar');
                }
                else {
                    ShowErrorDialog('Error al Reiniciar Layout', s.cp_mensaje, function () { });
                }
                break;
            }
            case "MostrarGrid": {
                lpPrincipal.Hide();
                lblTitle.SetText(s.cp_caption);

                if (s.cp_estado == 0) {
                    ShowErrorDialog('Error al Mostrar Datos', s.cp_mensaje, function () { });
                }
                else {
                    popDatos.Hide();
                    pgReportDataConsolidado.SetVisible(true);
                    gvReportDataDetallado.SetVisible(false);
                    hfId.Set("primeraVisualizacion", false);
                }
                break;
            }
        }

        delete (s.cp_mensaje);
        delete (s.cp_estado);
        delete (s.cp_evento);
    }

}

function GridEndCallbackDetail(s, e) {
    AdjustSize();
    if (s.cp_evento) {
        switch (s.cp_evento) {
            case "GuardarLayout": {
                if (s.cp_estado == 1) {
                    ShowSuccessDialog('Guardar Layout', s.cp_mensaje, function () { });
                }
                else {
                    ShowErrorDialog('Error al Guardar Layout', s.cp_mensaje, function () { });
                }
                break;
            }
            case "ReiniciarLayout": {
                if (s.cp_estado == 1) {
                    gvReportDataDetallado.PerformCallback('Refrescar');
                }
                else {
                    ShowErrorDialog('Error al Reiniciar Layout', s.cp_mensaje, function () { });
                }
                break;
            }
            case "MostrarGrid": {
                lpPrincipal.Hide();
                lblTitle.SetText(s.cp_caption);
                if (s.cp_estado == 0) {
                    ShowErrorDialog('Error al Mostrar Datos', s.cp_mensaje, function () { });
                }
                else {
                    popDatos.Hide();
                    pgReportDataConsolidado.SetVisible(false);
                    gvReportDataDetallado.SetVisible(true);
                    hfId.Set("primeraVisualizacion", false);
                }
                break;
            }
        }
        delete (s.cp_mensaje);
        delete (s.cp_estado);
        delete (s.cp_evento);
    }

}

function ClosePopUp(s, e) {
    lpPrincipal.Hide();
    popDatos.Hide();
}

function ShowDataGrid() {
    if (ASPxClientEdit.ValidateGroup('gvDatos')) {
        if (deInicio.GetDate() > deFinal.GetDate()) {
            ShowWarningDialog('Mostrar Reporte', 'La fecha inicial no puede ser mayor que la fecha final', function () { deFinal.SetDate(deInicio.GetDate()); });
        } else {
            lpPrincipal.Show();
            pgReportDataConsolidado.SetVisible(false);
            gvReportDataDetallado.SetVisible(false);
            hfId.Set("primeraVisualizacion", true);
            hfId.Set("jerarquia", gleJerarquia.GetValue());
            hfId.Set("idCliente", gleEmpresa.GetValue());
            lblTitle.SetText(DefTitleProcess);
            popDatos.Hide();
            if (hfId.Get("jerarquia") == 'J') {
                pgReportDataConsolidado.PerformCallback('MostrarGrid');
            } else {
                gvReportDataDetallado.PerformCallback('MostrarGrid');
            }

        }
    }
}

function OnInit(s, e) {
    AdjustSize();
    document.getElementById("gridContainer").style.visibility = "";
}

function OnControlsInitialized(s, e) {
    ASPxClientUtils.AttachEventToElement(window, "resize", function (evt) {
        AdjustSize();
    });
}
function AdjustSize() {
    var height = Math.max(0, document.documentElement.clientHeight);
    var width = Math.max(0, document.documentElement.clientWidth) - $(sidebar).width() - 100;

    gvReportDataDetallado.SetHeight(height - 140);
    pgReportDataConsolidado.SetHeight(height - 180);
    $(containerConsoldiado).width(width);
}

function DropDownSelectAll(s, e) {
    s.SelectAll();
}

function OnCallbackError(s, e) {
    e.handled = true;
    var errorMessageFromServer = e.message;
    ShowErrorDialog('Error al procesar solicitud', errorMessageFromServer, function () { lblTitle.SetText(DefTitle); });
}

var lastType = null;
function OnTypeChanged(s, e) {
    lpPrincipal.Show();
    if (s.InCallback())
        lastType = s.GetValue().toString();
    else{
        gleEmpresa.PerformCallback(s.GetValue().toString());
    }
}

function OnCompanyEndCallback(s, e) {
    lpPrincipal.Hide();
    if (lastType) {
        gleEmpresa.PerformCallback(lastType);
        lastType = null;
    }
    else {
        lpPrincipal.Show();
        if (gleEmpresa.GetValue() != null) {
            gleMonedero.PerformCallback(gleEmpresa.GetValue());
        } else {
            gleMonedero.PerformCallback(-100);
        }
    }
}

var lastClient = null;
function OnClientChanged(s, e) {
    lpPrincipal.Show();
    if (s.InCallback())
        lastClient = s.GetValue().toString();
    else {
        gleMonedero.PerformCallback(s.GetValue().toString());
    }
}

function OnMonederoEndCallback(s, e) {
    lpPrincipal.Hide();
    //if (lastType) {
    //    gleEmpresa.PerformCallback(lastType);
    //    lastType = null;
    //}
}

function OnSplitterPaneResized(s, e) {
    document.getElementById("tdTitle").style.width = (e.pane.lastWidth - 250) + "px";
    AdjustSize();
}

function OnGrigColumnResizing(s, e) {
    if (e.column.id == 'CommandCol')
        e.cancel = true;
}

$(document).ready(function () {
    pgReportDataConsolidado.SetVisible(false);
    gvReportDataDetallado.SetVisible(false);
    lblTitle.SetText(DefTitle);

});

