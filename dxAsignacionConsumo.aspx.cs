using Descuento.AdministracionCl;
using Descuento.Catalogo;
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
using DevExpress.XtraReports.UI;
using DevExpress.XtraPrinting.Shape;
using System.Drawing;

public partial class app_suscripcion_dxAsignacionConsumo : System.Web.UI.Page
{

    #region Variables

    private dalConsumoCombustible _oConsumoCombustibleDAL = new dalConsumoCombustible();
    private ClsGlobalTool tool = new ClsGlobalTool();
    private string conexion = System.Configuration.ConfigurationManager.ConnectionStrings["locDataConnStr"].ConnectionString;
    private string strTitle = "Periodo: {0}-{1}{2}{3}{4}{5}";
    private clsExporter _exporter;
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

    protected void menuPrincipal_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
    {
        switch (e.Item.Name)
        {
            case "ExportarXLS":
                {
                    gvReportSaldoTarjeta.SettingsText.Title = string.Empty;
                    _exporter = new clsExporter("CONSUMO DE COMBUSTIBLE DETALLADO", GetFiltersAsTitle(), gridExportDetallado, this.Response);
                    _exporter.ExportDataGridToExcelFile("Saldo de Tarjetas");
                    gvReportSaldoTarjeta.SettingsText.Title = "CONSUMO DE COMBUSTIBLE DETALLADO";
                }
                break;
        }
    }

    protected void gvReportDataDetallado_ClientLayout(object sender, ASPxClientLayoutArgs e)
    {
        if (e.LayoutMode == DevExpress.Web.ClientLayoutMode.Loading)
        {
            //Guardar Layout
            tool.GuardarLayout(User.Identity.Name, gvReportSaldoTarjeta.ID, gvReportSaldoTarjeta.SaveClientLayout(), false);
        }
    }

    protected void gvReportDataDetallado_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        Mensaje msg = new Mensaje();
        gvReportSaldoTarjeta.JSProperties["cp_evento"] = e.Parameters.ToString();

        switch (e.Parameters.ToString())
        {

            case "GuardarLayout":
                msg = tool.GuardarLayout(User.Identity.Name, gvReportSaldoTarjeta.ID, gvReportSaldoTarjeta.SaveClientLayout(), true);
                gvReportSaldoTarjeta.JSProperties["cp_mensaje"] = msg.Descripcion;
                gvReportSaldoTarjeta.JSProperties["cp_estado"] = msg.Estado;
                break;
            case "ReiniciarLayout":
                msg = tool.ResetLayout(User.Identity.Name, gvReportSaldoTarjeta.ID);
                if (msg.Estado == 1)
                {
                    gvReportSaldoTarjeta.LoadClientLayout(msg.Descripcion);
                }
                gvReportSaldoTarjeta.JSProperties["cp_mensaje"] = msg.Descripcion;
                gvReportSaldoTarjeta.JSProperties["cp_estado"] = msg.Estado;
                break;
            case "MostrarGrid":
                {
                    gvReportSaldoTarjeta.JSProperties["cp_caption"] = GetFiltersAsTitle();

                    try
                    {
                        Session[hfId["sessionId"] + "dxAsignacionConsumo.Periodo"] = new DateTime((int)gleAnio.Value, (int)gleMes.Value, DateTime.Now.Day);
                        Session[hfId["sessionId"] + "dxAsignacionConsumo.Reporte"] = _oConsumoCombustibleDAL.ObtenerReporteSaldoTarjetas(User.Identity.Name, (DateTime) Session[hfId["sessionId"] + "dxAsignacionConsumo.Periodo"], gleTipo.Value.ToString(),(int)gleEmpresa.Value,gleTipoProducto.Value.ToString(),gleProducto.Value.ToString(),gleOtro.Value.ToString(),txtValor.Text.Trim());
                        CargarDatosSesion(false);
                        gvReportSaldoTarjeta.ExpandAll();
                        gvReportSaldoTarjeta.JSProperties["cp_mensaje"] = string.Empty;
                        gvReportSaldoTarjeta.JSProperties["cp_estado"] = 1;
                    }
                    catch (Exception ex)
                    {
                        gvReportSaldoTarjeta.JSProperties["cp_mensaje"] = ex.Message;
                        gvReportSaldoTarjeta.JSProperties["cp_estado"] = 0;
                    }

                    break;
                }
            default:
                break;
        }
    }
    protected void gleEmpresa_Callback(object sender, CallbackEventArgsBase e)
    {
        Session[hfId["sessionId"] + "dxAsignacionConsumo.Empresas"] = dalEmpresa.ObtenerEmpresasAsignadasxUsuario(conexion, User.Identity.Name, true, gleTipo.Value == null ? "" : gleTipo.Value.ToString());
        CargarDatosEmpresa();
       // if (((DataTable)gleEmpresa.DataSource).Rows.Count > 0)
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

    protected void gvReportDataDetallado_CustomJSProperties(object sender, ASPxGridViewClientJSPropertiesEventArgs e)
    {
        e.Properties["cpGroupCount"] = gvReportSaldoTarjeta.GroupCount;
    }

    #endregion

    #region Funciones

    private string GetFiltersAsTitle()
    {
        return string.Format(strTitle,gleMes.Text,gleAnio.Text,gleTipo.Value.ToString() == "T"?string.Empty:" | "+gleTipo.Text, gleEmpresa.Value.ToString() == "0" ? string.Empty : " | " + gleEmpresa.Text, gleTipoProducto.Value.ToString() == "T" ? string.Empty : " | " + gleTipoProducto.Text, gleProducto.Value.ToString() == "T" ? string.Empty : " | " + gleProducto.Text);
    }
    /*Configuración inicial de los controles*/
    private void ConfigControlsInit()
    {
        hfId["sessionId"] = Guid.NewGuid();
        gleMes.Value = DateTime.Today.Month;
        gleAnio.Value = DateTime.Today.Year;

        Session[hfId["sessionId"] + "dxAsignacionConsumo.TipoCliente"] = dalEmpresa.ObtenerTipoEmpresaXUsuario(conexion, User.Identity.Name,false,true);
        Session[hfId["sessionId"] + "dxAsignacionConsumo.Empresas"] = dalEmpresa.ObtenerEmpresasAsignadasxUsuario(conexion, User.Identity.Name, true, "T");
        Session[hfId["sessionId"] + "dxAsignacionConsumo.Productos"] = dalEmpresa.ObtenerMonederosXEmpresaUsuario(conexion, User.Identity.Name,"T",0);
        Session[hfId["sessionId"] + "dxAsignacionConsumo.TipoProductos"] = dalEmpresa.ObtenerTipoMonederosXEmpresaUsuario(conexion, User.Identity.Name,false,0);
        gvReportSaldoTarjeta.SettingsBehavior.AutoExpandAllGroups = true;
    }

    /*Cargar Layout del Grid*/
    private void CargarLayouts()
    {
        //Cargar Layout del Grid Detallado
        string layout = tool.ObtenerLayout(User.Identity.Name, gvReportSaldoTarjeta.ID.ToString());
        if (layout != string.Empty)
        {
            gvReportSaldoTarjeta.LoadClientLayout(layout);
        }
    }

    /*Cargar Sesiones en los Controles*/
    private void CargarDatosSesion(bool firstLoad)
    {
        gvReportSaldoTarjeta.DataSource = Session[hfId["sessionId"] + "dxAsignacionConsumo.Reporte"];
        gvReportSaldoTarjeta.DataBind();

        gvDetalleSaldo.DataSource = Session[hfId["sessionId"] + "dxAsignacionConsumo.ReporteDetalle"];
        gvDetalleSaldo.DataBind();

        CargarDatosTipoCliente();
        CargarDatosEmpresa();
        CargarDatosProductos();
        CargarDatosTipoProductos();

        if (firstLoad)
        {
            gleEmpresa.SelectedIndex = 0;
            gleTipo.SelectedIndex = 0;
            gleProducto.SelectedIndex = 0;
            gleTipoProducto.SelectedIndex = 0;
            hfId["idCliente"] = gleEmpresa.Value == null? -1:gleEmpresa.Value;
            if (gleTipoProducto.Value != null) {
                hfId["idModalidad"] = gleTipoProducto.Value;
            }
        }
    }

    private void PermanentConfig()
    {

        if (!_oConsumoCombustibleDAL.PoseeTarjetasDeVolumen(User.Identity.Name,hfId["idCliente"].ToString()) || "D".Contains(hfId["idModalidad"].ToString()))
        {
            gvReportSaldoTarjeta.Columns["ASIGNADOGLN"].Visible = false;
            gvReportSaldoTarjeta.Columns["ASIGNADOGLN"].ShowInCustomizationForm = false;

            gvReportSaldoTarjeta.Columns["DESPACHADO_COR"].Visible = false;
            gvReportSaldoTarjeta.Columns["DESPACHADO_COR"].ShowInCustomizationForm = false;

            gvReportSaldoTarjeta.Columns["DESPACHOGLN"].Visible = false;
            gvReportSaldoTarjeta.Columns["DESPACHOGLN"].ShowInCustomizationForm = false;

            gvReportSaldoTarjeta.Columns["DISPONIBLEGLN"].Visible = false;
            gvReportSaldoTarjeta.Columns["DISPONIBLEGLN"].ShowInCustomizationForm = false;
        }

        gvReportSaldoTarjeta.SettingsResizing.ColumnResizeMode = (ColumnResizeMode)Enum.Parse(typeof(ColumnResizeMode), "Control", true);
        gvReportSaldoTarjeta.SettingsResizing.Visualization = (ResizingMode)Enum.Parse(typeof(ResizingMode), "Live", true);
    }

    public void CargarDatosEmpresa()
    {

        gleEmpresa.DataSource = Session[hfId["sessionId"] + "dxAsignacionConsumo.Empresas"];
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
        gleTipo.DataSource = Session[hfId["sessionId"] + "dxAsignacionConsumo.TipoCliente"];
        gleTipo.DataBind();

        foreach (ListEditItem item in gleTipo.Items)
        {
            if (item.Value.ToString() == "T")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

 
    public void CargarDatosProductos()
    {
        gleProducto.DataSource = Session[hfId["sessionId"] + "dxAsignacionConsumo.Productos"];
        gleProducto.DataBind();

        foreach (ListEditItem item in gleProducto.Items)
        {
            if (item.Value.ToString() == "T")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    public void CargarDatosTipoProductos()
    {
        gleTipoProducto.DataSource = Session[hfId["sessionId"] + "dxAsignacionConsumo.TipoProductos"];
        gleTipoProducto.DataBind();

        foreach (ListEditItem item in gleTipoProducto.Items)
        {
            if (item.Value.ToString() == "C")
            {
                item.ImageUrl = "~/app/Images/gas-24.png";
            }
            else if (item.Value.ToString() == "D")
            {
                item.ImageUrl = "~/app/Images/Money-24.png";
            }
            else {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    #endregion



    protected void gvReportDataDetallado_Init(object sender, EventArgs e)
    {
      //  gvReportDataDetallado.Templates.GroupRowContent = new GridGroupRowContentTemplate();
    }

    protected void gleProducto_Callback(object sender, CallbackEventArgsBase e)
    {
        Session[hfId["sessionId"] + "dxAsignacionConsumo.Productos"] = dalEmpresa.ObtenerMonederosXEmpresaUsuario(conexion, User.Identity.Name, gleTipo.Value.ToString(), gleEmpresa.Value == null? -100 : (int)gleEmpresa.Value);
        CargarDatosProductos();
       
        //if (((DataTable)gleProducto.DataSource).Rows.Count>0)
        gleProducto.SelectedIndex = 0;
    }

    protected void gleProducto_DataBound(object sender, EventArgs e)
    {
        foreach (ListEditItem item in gleProducto.Items)
        {
            if (item.Value.ToString() == "T")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    protected void gleTipoProducto_DataBound(object sender, EventArgs e)
    {
        foreach (ListEditItem item in gleTipoProducto.Items)
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

    protected void gleTipoProducto_Callback(object sender, CallbackEventArgsBase e)
    {

        Session[hfId["sessionId"] + "dxAsignacionConsumo.TipoProductos"] = dalEmpresa.ObtenerTipoMonederosXEmpresaUsuario(conexion, User.Identity.Name,false, gleEmpresa.Value == null ? -100 : (int)gleEmpresa.Value);
        CargarDatosTipoProductos();
        //if (((DataTable)gleProducto.DataSource).Rows.Count>0)
     gleTipoProducto.SelectedIndex = 0;
    }

    protected void popDetail_WindowCallback(object source, PopupWindowCallbackArgs e)
    {
        string idVehiculo = e.Parameter.ToString();

        Session[hfId["sessionId"] + "dxAsignacionConsumo.ReporteDetalle"] = _oConsumoCombustibleDAL.ObtenerDetalleSaldo(idVehiculo, (DateTime) Session[hfId["sessionId"] + "dxAsignacionConsumo.Periodo"]);
        gvDetalleSaldo.DataSource = Session[hfId["sessionId"] + "dxAsignacionConsumo.ReporteDetalle"];
        gvDetalleSaldo.DataBind();
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        gridExportPopupDetalle.WriteXlsToResponse();
    }
}