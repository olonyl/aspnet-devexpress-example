using Descuento.AdministracionCl;
using DevExpress.Data;
using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPivotGrid;
using DevExpress.XtraPrinting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;


public partial class app_suscripcion_dxConsumoCombustibleConsolidado : System.Web.UI.Page
{

    #region Variables

    private dalConsumoCombustible _oConsumoCombustibleDAL = new dalConsumoCombustible();
    private ClsGlobalTool tool = new ClsGlobalTool();
    private string conexion = System.Configuration.ConfigurationManager.ConnectionStrings["locDataConnStr"].ConnectionString;
    private string strTitle = "{0}  {1}: {2:dd-MM-yyyy} al {3:dd-MM-yyyy} {4} {5}";
    private clsExporter _exporter;
    decimal _summaryTotal = decimal.Zero;
    #endregion

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ConfigControlsInit();
            CargarDatosSesion(true);
            CargarLayouts();

        }
        else
        {
            CargarDatosSesion(false);
        }

        PermanentConfig();

    }

    protected void pgReportDataConsolidado_CustomCallback(object sender, DevExpress.Web.ASPxPivotGrid.PivotGridCustomCallbackEventArgs e)
    {
        Mensaje msg = new Mensaje();
        pgReportDataConsolidado.JSProperties["cp_evento"] = e.Parameters.ToString();

        switch (e.Parameters.ToString())
        {

            case "GuardarLayout":
                msg = tool.GuardarLayout(User.Identity.Name, pgReportDataConsolidado.ID, pgReportDataConsolidado.SaveLayoutToString(), true);
                pgReportDataConsolidado.JSProperties["cp_mensaje"] = msg.Descripcion;
                pgReportDataConsolidado.JSProperties["cp_estado"] = msg.Estado;
                break;
            case "ReiniciarLayout":
                msg = tool.ResetLayout(User.Identity.Name, pgReportDataConsolidado.ID);
                if (msg.Estado == 1)
                {
                    pgReportDataConsolidado.LoadLayoutFromString(msg.Descripcion);
                }
                pgReportDataConsolidado.JSProperties["cp_mensaje"] = msg.Descripcion;
                pgReportDataConsolidado.JSProperties["cp_estado"] = msg.Estado;
                break;
            case "MostrarGrid":
                {
                    pgReportDataConsolidado.JSProperties["cp_caption"] = GetFiltersAsTitle();

                    try
                    {
                        CargarDatosIniciales();
                        CargarDatosSesion(false);
                        pgReportDataConsolidado.JSProperties["cp_mensaje"] = string.Empty;
                        pgReportDataConsolidado.JSProperties["cp_estado"] = 1;
                    }
                    catch (Exception ex)
                    {
                        pgReportDataConsolidado.JSProperties["cp_mensaje"] = ex.Message;
                        pgReportDataConsolidado.JSProperties["cp_estado"] = 0;
                    }

                    break;
                }
            default:
                break;
        }
    }

    protected void menuPrincipal_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
    {
        switch (e.Item.Name)
        {
            case "ExportarXLS":
                {
                    if (hfId["jerarquia"].ToString() == "J")
                    {
                        _exporter = new clsExporter("CONSUMO DE COMBUSTIBLE CONSOLIDADO POR JERARQUÍA", GetFiltersAsTitle(), gridExportConsolidado, this.Response);
                        _exporter.ExportPivotGridToExcelFile();
                    }
                    else if (hfId["jerarquia"].ToString() == "V")
                    {
                        gvReportDataDetallado.SettingsText.Title = string.Empty;
                        _exporter = new clsExporter("CONSUMO DE COMBUSTIBLE CONSOLIDADO POR VEHÍCULO", GetFiltersAsTitle(), gridExportDetallado, this.Response);
                        _exporter.ExportDataGridToExcelFile("Consumo Consolidado de Vehiculo");
                        gvReportDataDetallado.SettingsText.Title = "CONSUMO DE COMBUSTIBLE CONSOLIDADO POR VEHÍCULO";
                    }
                }
                break;
        }
    }
    protected void pgReportDataConsolidado_ClientLayout(object sender, DevExpress.Web.ASPxClientLayoutArgs e)
    {
        if (e.LayoutMode == DevExpress.Web.ClientLayoutMode.Loading)
        {
            //Guardar Layout
            tool.GuardarLayout(User.Identity.Name, pgReportDataConsolidado.ID, pgReportDataConsolidado.SaveLayoutToString(), false);
        }
    }


    protected void gvReportDataDetallado_ClientLayout(object sender, ASPxClientLayoutArgs e)
    {
        if (e.LayoutMode == DevExpress.Web.ClientLayoutMode.Loading)
        {
            //Guardar Layout
            tool.GuardarLayout(User.Identity.Name, gvReportDataDetallado.ID, gvReportDataDetallado.SaveClientLayout(), false);
        }
    }

    protected void gvReportDataDetallado_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        Mensaje msg = new Mensaje();
        gvReportDataDetallado.JSProperties["cp_evento"] = e.Parameters.ToString();

        switch (e.Parameters.ToString())
        {

            case "GuardarLayout":
                msg = tool.GuardarLayout(User.Identity.Name, gvReportDataDetallado.ID, gvReportDataDetallado.SaveClientLayout(), true);
                gvReportDataDetallado.JSProperties["cp_mensaje"] = msg.Descripcion;
                gvReportDataDetallado.JSProperties["cp_estado"] = msg.Estado;
                break;
            case "ReiniciarLayout":
                msg = tool.ResetLayout(User.Identity.Name, gvReportDataDetallado.ID);
                if (msg.Estado == 1)
                {
                    gvReportDataDetallado.LoadClientLayout(msg.Descripcion);
                }
                gvReportDataDetallado.JSProperties["cp_mensaje"] = msg.Descripcion;
                gvReportDataDetallado.JSProperties["cp_estado"] = msg.Estado;
                break;
            case "MostrarGrid":
                {
                    gvReportDataDetallado.JSProperties["cp_caption"] = GetFiltersAsTitle();

                    try
                    {
                        CargarDatosIniciales();
                        CargarDatosSesion(false);
                        gvReportDataDetallado.ExpandAll();
                        gvReportDataDetallado.JSProperties["cp_mensaje"] = string.Empty;
                        gvReportDataDetallado.JSProperties["cp_estado"] = 1;
                    }
                    catch (Exception ex)
                    {
                        gvReportDataDetallado.JSProperties["cp_mensaje"] = ex.Message;
                        gvReportDataDetallado.JSProperties["cp_estado"] = 0;
                    }

                    break;
                }
            default:
                break;
        }
    }
    protected void gleEmpresa_Callback(object sender, CallbackEventArgsBase e)
    {
        Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.Empresas"] = dalEmpresa.ObtenerEmpresasAsignadasxUsuario(conexion, User.Identity.Name, true, gleTipo.Value == null ? "" : gleTipo.Value.ToString());
        CargarDatosEmpresa();
        gleEmpresa.SelectedIndex = 0;
    }

    protected void gleEmpresa_DataBound(object sender, EventArgs e)
    {
        foreach (ListEditItem item in gleEmpresa.Items)
        {
            if (item.Value.ToString() == "0")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
        
    }

    protected void pgReportDataConsolidado_FieldValueDisplayText(object sender, DevExpress.Web.ASPxPivotGrid.PivotFieldDisplayTextEventArgs e)
    {
        if (e.ValueType == PivotGridValueType.Total)
        {
            e.DisplayText = string.Format("Total [ {0} ]", e.Value);
        }
    }

    #endregion

    #region Funciones

    private string GetFiltersAsTitle()
    {
        return string.Format(strTitle, (gleEmpresa.Value.ToString() == "0" ? string.Empty : gleEmpresa.SelectedItem.Text + " |"), rbTipoFecha.SelectedItem.Text, deInicio.Date, deFinal.Date, (gleMonedero.Value.ToString() == "T" ? string.Empty : "| " + gleMonedero.SelectedItem.Text), (gleTipo.Value.ToString() == "T" ? string.Empty : "| " + gleTipo.SelectedItem.Text));
    }
    /*Configuración inicial de los controles*/
    private void ConfigControlsInit()
    {
        hfId["sessionId"] = Guid.NewGuid();
        hfId["primeraVisualizacion"] = true;
        hfId["jerarquia"] = 'N';
        deInicio.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        deFinal.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month));

        Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.TipoCliente"] = dalEmpresa.ObtenerTipoEmpresaXUsuario(conexion, User.Identity.Name,true,true);

        Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.Empresas"] = dalEmpresa.ObtenerEmpresasAsignadasxUsuario(conexion, User.Identity.Name, true, "T");

    }

    /*Cargar Layout del Grid*/
    private void CargarLayouts()
    {
        //Cargar Layout del Consolidado
        string layout = tool.ObtenerLayout(User.Identity.Name, pgReportDataConsolidado.ID.ToString());
        if (layout != string.Empty)
        {
            pgReportDataConsolidado.LoadLayoutFromString(layout);
        }

        //Cargar Layout del Grid Detallado
        layout = tool.ObtenerLayout(User.Identity.Name, gvReportDataDetallado.ID.ToString());
        if (layout != string.Empty)
        {
            gvReportDataDetallado.LoadClientLayout(layout);
        }
    }

    /*Cargar Datos iniciales en variables de sesion*/
    private void CargarDatosIniciales()
    {
        if (hfId["jerarquia"].ToString() == "J")
        {
            Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.ReporteDetallado"] = _oConsumoCombustibleDAL.ObtenerConsumoCombustibleConsolidado(User.Identity.Name, deInicio.Date, deFinal.Date, (Int32)gleEmpresa.Value, rbTipoFecha.Value.ToString() , gleMonedero.Value.ToString(), gleTipo.Value.ToString());
        }
        else if (hfId["jerarquia"].ToString() == "V")
        {
            Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.ReporteConsolidado"] = _oConsumoCombustibleDAL.ObtenerConsumoCombustibleConsolidado(User.Identity.Name, deInicio.Date, deFinal.Date, (Int32)gleEmpresa.Value, rbTipoFecha.Value.ToString() , gleMonedero.Value.ToString(), gleTipo.Value.ToString());
        }

    }
    /*Cargar Sesiones en los Controles*/
    private void CargarDatosSesion(bool firstLoad)
    {
        if (hfId["jerarquia"].ToString() == "J")
        {
            pgReportDataConsolidado.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.ReporteDetallado"];
            pgReportDataConsolidado.DataBind();
            pgReportDataConsolidado.ReloadData();
        }
        else if (hfId["jerarquia"].ToString() == "V")
        {
            gvReportDataDetallado.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.ReporteConsolidado"];
            gvReportDataDetallado.DataBind();
        }

        if (firstLoad) {
             Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.TipoProductos"] = dalEmpresa.ObtenerTipoMonederosXEmpresaUsuario(conexion, User.Identity.Name, true,0);

        }
      
        CargarDatosTipoCliente();
        CargarDatosEmpresa();
        CargarDatosTipoProductos();
        if (firstLoad)
        {
            gleTipo.SelectedIndex = 0;
            gleEmpresa.SelectedIndex = 0;
            gleMonedero.SelectedIndex = 0;
            hfId["idCliente"] = gleEmpresa.Value == null ? -1 : gleEmpresa.Value;
        }
             
    }
    private void PermanentConfig()
    {
        pgReportDataConsolidado.OptionsView.ShowFilterHeaders = false;

        if (!_oConsumoCombustibleDAL.PoseeEmpresasDeDescuento(User.Identity.Name,hfId["idCliente"].ToString()))
        {
            pgReportDataConsolidado.Fields.Remove(fieldSubTotalCordobas);
            pgReportDataConsolidado.Fields.Remove(fieldDescuentoCordobas);
            pgReportDataConsolidado.Fields.Remove(fieldSubTotalDolares);
            pgReportDataConsolidado.Fields.Remove(fieldDescuentoDolares);

            gvReportDataDetallado.Columns["SUBTOTAL_CORDOBAS"].Visible = false;
            gvReportDataDetallado.Columns["SUBTOTAL_CORDOBAS"].ShowInCustomizationForm = false;
            gvReportDataDetallado.Columns["DESCUENTO_CORDOBAS"].Visible = false;
            gvReportDataDetallado.Columns["DESCUENTO_CORDOBAS"].ShowInCustomizationForm = false;

            gvReportDataDetallado.Columns["SUBTOTAL_DOLARES"].Visible = false;
            gvReportDataDetallado.Columns["SUBTOTAL_DOLARES"].ShowInCustomizationForm = false;
            gvReportDataDetallado.Columns["DESCUENTO_DOLARES"].Visible = false;
            gvReportDataDetallado.Columns["DESCUENTO_DOLARES"].ShowInCustomizationForm = false;
        }

        gvReportDataDetallado.SettingsResizing.ColumnResizeMode = (ColumnResizeMode)Enum.Parse(typeof(ColumnResizeMode), "Control", true);
        gvReportDataDetallado.SettingsResizing.Visualization = (ResizingMode)Enum.Parse(typeof(ResizingMode), "Live", true);
    }

    private void ExportPivotGridToExcelFile_OldWay()
    {
        const string fileName = "ConsolidadDeConsumo";
        XlsxExportOptionsEx options;
        options = new XlsxExportOptionsEx()
        {
            ExportType = ExportType.WYSIWYG,
            AllowGrouping = DevExpress.Utils.DefaultBoolean.False,
            AllowFixedColumns = DevExpress.Utils.DefaultBoolean.False,
            AllowFixedColumnHeaderPanel = DevExpress.Utils.DefaultBoolean.False,
            ShowPageTitle = DevExpress.Utils.DefaultBoolean.True

        };

        gridExportConsolidado.ExportXlsxToResponse(fileName, options, false);
    }

    public void CargarDatosEmpresa()
    {

        gleEmpresa.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.Empresas"];
        gleEmpresa.DataBind();

        foreach (ListEditItem item in gleEmpresa.Items)
        {
            if (item.Value.ToString() == "0")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    public void CargarDatosTipoCliente()
    {
        gleTipo.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.TipoCliente"];
        gleTipo.DataBind();

        foreach (ListEditItem item in gleTipo.Items)
        {
            if (item.Value.ToString() == "T")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    public void CargarDatosTipoProductos()
    {
        gleMonedero.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.TipoProductos"];
        gleMonedero.DataBind();

        foreach (ListEditItem item in gleMonedero.Items)
        {
            if (item.Value.ToString() == "C")
            {
                item.ImageUrl = "~/app/Images/gas-24.png";
            }
            else if (item.Value.ToString() == "D")
            {
                item.ImageUrl = "~/app/Images/Money-24.png";
            }
            else
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }
    #endregion


    protected void gleMonedero_DataBound(object sender, EventArgs e)
    {
        foreach (ListEditItem item in gleMonedero.Items)
        {
            if (item.Value.ToString() == "C")
            {
                item.ImageUrl = "~/app/Images/gas-24.png";
            }
            else if (item.Value.ToString() == "D")
            {
                item.ImageUrl = "~/app/Images/Money-24.png";
            }
            else
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    protected void gleMonedero_Callback(object sender, CallbackEventArgsBase e)
    {
        Session[hfId["sessionId"] + "dxConsumoCombustibleConsolidado.TipoProductos"] = dalEmpresa.ObtenerTipoMonederosXEmpresaUsuario(conexion, User.Identity.Name,true, gleEmpresa.Value == null ? -100 : (int)gleEmpresa.Value);
        CargarDatosTipoProductos();
        //if (((DataTable)gleProducto.DataSource).Rows.Count>0)
        gleMonedero.SelectedIndex = 0;
    }
}