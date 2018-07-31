var DefTitle = 'CONSUMO DE COMBUSTIBLE DETALLADO | SELECCIONAR FILTRO';
var DefTitleProcess = 'CONSUMO DE COMBUSTIBLE DETALLADO | PROCESANDO SOLICITUD';

/*Tool Bar Menu*/
function ItemClickClientEvent(s, e) {

    switch (e.item.name) {
        case "GuardarLayout":
            e.processOnServer = false;
            gvReportDataDetallado.PerformCallback(e.item.name);
            break;
        case "PersonalizarGrid":
            e.processOnServer = false;
            if (gvReportDataDetallado.IsCustomizationWindowVisible())
                gvReportDataDetallado.HideCustomizationWindow();
            else
                gvReportDataDetallado.ShowCustomizationWindow();
            break;
        case "ConfigurarLayout":
            e.processOnServer = false;
            break;
        case "ReiniciarLayout":
            e.processOnServer = false;
            gvReportDataDetallado.PerformCallback(e.item.name);
            break;
        case "Filter":
            e.processOnServer = false;
            popDatos.Show();
            break;
    }
}

var command = "";
function BeginGridCallback(s, e) {
    command = e.command;
}

function GridEndCallback(s, e) {
    
    chkExpandGrid.SetEnabled(gvReportDataDetallado.cpGroupCount > 0);
    if (command == 'GROUP' || command == 'UNGROUP') {
        chkExpandGrid.SetChecked(true);
    }

    AdjustSummaryTable();
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
                // lpPrincipal.Hide();
                lblTitle.SetText(s.cp_caption);
                if (s.cp_estado == 0) {
                    ShowErrorDialog('Error al Mostrar Datos', s.cp_mensaje, function () { });
                }
                else {
                    chkExpandGrid.SetChecked(true);
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
    //lpPrincipal.Hide();
    popDatos.Hide();
}

function ShowDataGrid() {
    if (ASPxClientEdit.ValidateGroup('gvDatos')) {
        if (deInicio.GetDate() > deFinal.GetDate()) {
            ShowWarningDialog('Mostrar Reporte', 'La fecha inicial no puede ser mayor que la fecha final', function () { deFinal.SetDate(deInicio.GetDate()); });
        } else {
            hfId.Set("idCliente", gleEmpresa.GetValue());
            lblTitle.SetText(DefTitleProcess);
            popDatos.Hide();
            gvReportDataDetallado.PerformCallback('MostrarGrid');

        }
    }
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
    else {
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


function OnTipoProductoEndCallback(s, e) {
    lpPrincipal.Hide();
}



var lastSource = null;
function OnSourceChanged(s, e) {
    lpPrincipal.Show();
    if (s.InCallback())
        lastSource = s.GetValue().toString();
    else {
        gleEstacion.PerformCallback(s.GetValue().toString());
    }
}

function OnStationEndCallback(s, e) {
    lpPrincipal.Hide();
    if (lastSource) {
        gleEstacion.PerformCallback(lastSource);
        lastSource = null;
    }
}

function OnSplitterPaneResized(s, e) {
    document.getElementById("tdTitle").style.width = (e.pane.lastWidth - 250) + "px";
}

function OtroSelectIndexChanged(s, e) {
    if (s.GetValue().toString() == 'T') {
        txtValor.SetText('');
        txtValor.SetEnabled(false);
    } else {
        txtValor.SetEnabled(true);
        window.setTimeout(function () {
            txtValor.Focus();
            txtValor.SelectAll();
        }, 200);


    }
}

function OnGrigColumnResizing(s, e) {
    if (e.column.id == 'CommandCol')
        e.cancel = true;
}

function ExpandGroups(s, e) {

    if (chkExpandGrid.GetChecked())
        gvReportDataDetallado.ExpandAll();
    else
        gvReportDataDetallado.CollapseAll();
}

function OnInit(s, e) {
    AdjustSize();
    AdjustSummaryTable();
    document.getElementById("gridContainer").style.visibility = "";
}

function OnControlsInitialized(s, e) {
    ASPxClientUtils.AttachEventToElement(window, "resize", function (evt) {
        AdjustSize();
        AdjustSummaryTable();
    });
}
function AdjustSize() {
    var height = Math.max(0, document.documentElement.clientHeight);
    gvReportDataDetallado.SetHeight(height - 140);
}

function Grid_ColumnResized(s, e) {
    //AdjustSummaryTable();
}

function AdjustSummaryTable() {
    //RemoveCustomStyleElement();
    //var styleRules = [];
    //var headerRow = GetGridHeaderRow(grid);
    //if (!headerRow)
    //    return;
    //var headerCells = headerRow.getElementsByClassName("gridHeader");
    //var totalWidth = 0;
    //for (var i = 0; i < headerCells.length; i++)
    //    styleRules.push(CreateStyleRule(headerCells[i], i));
    //AppendStyleToHeader(styleRules);
}

function CreateStyleRule(headerCell, headerIndex) {
    //var width = headerCell.offsetWidth;
    //var cellRule = ".summaryCell_" + headerIndex;
    //return cellRule + ", " + cellRule + " .summaryTextContainer" + "{ width:" + width + "px; }";
}

function GetGridHeaderRow(grid) {
    //var headers = gvReportDataDetallado.GetMainElement().getElementsByClassName("dxgvHeader_Material gridVisibleColumn");
    //if (headers.length > 0)
    //    return headers[0].parentNode;
}

var customStyleElement = null;
function AppendStyleToHeader(styleRules) {
    //var container = document.createElement("DIV");
    //container.innerHTML = "<style type='text/css'>" + styleRules.join("") + "</style>";

    //var head = document.getElementsByTagName("HEAD")[0];
    //customStyleElement = container.getElementsByTagName("STYLE")[0];

    //head.appendChild(customStyleElement);
}
function RemoveCustomStyleElement() {
    //if (customStyleElement) {
    //    customStyleElement.parentNode.removeChild(customStyleElement);
    //    customStyleElement = null;
    //}
}

$(document).ready(function () {
    lblTitle.SetText(DefTitle);
    txtValor.SetEnabled(false);
    chkExpandGrid.SetEnabled(false);
    $('#chkExpandGridTD').click(function () {
        if (chkExpandGrid.GetEnabled()) {
            chkExpandGrid.SetChecked(!chkExpandGrid.GetChecked());
            if (chkExpandGrid.GetChecked())
                gvReportDataDetallado.ExpandAll();
            else
                gvReportDataDetallado.CollapseAll();
        }
    });
});

