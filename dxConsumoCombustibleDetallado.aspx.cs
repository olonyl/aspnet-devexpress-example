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

public partial class app_suscripcion_dxConsumoCombustibleDetallado : System.Web.UI.Page
{

    #region Variables

    private dalConsumoCombustible _oConsumoCombustibleDAL = new dalConsumoCombustible();
    private ClsGlobalTool tool = new ClsGlobalTool();
    private string conexion = System.Configuration.ConfigurationManager.ConnectionStrings["locDataConnStr"].ConnectionString;
    private string strTitle = "{0}  {1}: {2:dd-MM-yyyy} al {3:dd-MM-yyyy} {4} {5} {6}";
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
                    gvReportDataDetallado.SettingsText.Title = string.Empty;
                    _exporter = new clsExporter("CONSUMO DE COMBUSTIBLE DETALLADO", GetFiltersAsTitle(), gridExportDetallado, this.Response);
                    _exporter.ExportDataGridToExcelFile("Consumo Detallado de Vehiculo");
                    gvReportDataDetallado.SettingsText.Title = "CONSUMO DE COMBUSTIBLE DETALLADO";

                }
                break;
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
                        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Reporte"] = _oConsumoCombustibleDAL.ObtenerConsumoCombustible(User.Identity.Name, rbTipoFecha.Value.ToString(), deInicio.Date, deFinal.Date, (int)gleFuente.Value,(int) gleEstacion.Value, (int)gleEmpresa.Value,(int)gleProducto.Value,txtValor.Text.Trim(),gleTipo.Value.ToString(),gleMonedero.Value.ToString(), gleOtro.Value.ToString());
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
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Empresas"] = dalEmpresa.ObtenerEmpresasAsignadasxUsuario(conexion, User.Identity.Name, true, gleTipo.Value == null ? "" : gleTipo.Value.ToString());
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

    protected void gleEstacion_Callback(object sender, CallbackEventArgsBase e)
    {
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Estaciones"] = Estacion.ObtenerEstacionesAsignadasxUsuario(conexion, User.Identity.Name, gleFuente.Value == null? -2:(int)gleFuente.Value);
        CargarDatosEstaciones();
        gleEstacion.SelectedIndex = 0;
    }

    protected void gleEstacion_DataBound(object sender, EventArgs e)
    {
        foreach (ListEditItem item in gleEstacion.Items)
        {
            if (item.Value.ToString() == "0")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
        
    }
    protected void gvReportDataDetallado_CustomJSProperties(object sender, ASPxGridViewClientJSPropertiesEventArgs e)
    {
        e.Properties["cpGroupCount"] = gvReportDataDetallado.GroupCount;
    }

    #endregion

    #region Funciones

    private string GetFiltersAsTitle()
    {
        return string.Format(strTitle, (gleEmpresa.Value.ToString() == "0" ? string.Empty : gleEmpresa.SelectedItem.Text + " |"), rbTipoFecha.SelectedItem.Text, deInicio.Date, deFinal.Date, (gleMonedero.Value.ToString() == "T" ? string.Empty : "| " + gleMonedero.SelectedItem.Text), (gleEstacion.Value.ToString() == "0" ? string.Empty : "| " + gleEstacion.SelectedItem.Text), (gleTipo.Value.ToString() == "T" ? string.Empty : "| " + gleTipo.SelectedItem.Text));
    }
    /*Configuración inicial de los controles*/
    private void ConfigControlsInit()
    {
        hfId["sessionId"] = Guid.NewGuid();
        deInicio.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        deFinal.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month));

        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.TipoCliente"] = dalEmpresa.ObtenerTipoEmpresaXUsuario(conexion, User.Identity.Name,true,true);
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Empresas"] = dalEmpresa.ObtenerEmpresasAsignadasxUsuario(conexion, User.Identity.Name, true, "T");
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Fuente"] = Estacion.ObtenerFuentesAsignadasxUsuario(conexion, User.Identity.Name);
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Estaciones"] = Estacion.ObtenerEstacionesAsignadasxUsuario(conexion, User.Identity.Name, 0);
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Productos"] = dalCombustible.ObtenerCatalogoDeCombustiblesParaDDL(conexion);
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.TipoProductos"] = dalEmpresa.ObtenerTipoMonederosXEmpresaUsuario(conexion, User.Identity.Name, true, 0);
        gvReportDataDetallado.SettingsBehavior.AutoExpandAllGroups = true;
    }

    /*Cargar Layout del Grid*/
    private void CargarLayouts()
    {
        //Cargar Layout del Grid Detallado
        string layout = tool.ObtenerLayout(User.Identity.Name, gvReportDataDetallado.ID.ToString());
        if (layout != string.Empty)
        {
            gvReportDataDetallado.LoadClientLayout(layout);
        }
    }

    /*Cargar Sesiones en los Controles*/
    private void CargarDatosSesion(bool firstLoad)
    {
        gvReportDataDetallado.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Reporte"];
        gvReportDataDetallado.DataBind();

        CargarDatosTipoCliente();
        CargarDatosFuente();
        CargarDatosEmpresa();
        CargarDatosEstaciones();
        CargarDatosProductos();
        CargarDatosTipoProductos();
        if (firstLoad)
        {
            gleFuente.SelectedIndex = 0;
            gleEmpresa.SelectedIndex = 0;
            gleTipo.SelectedIndex = 0;
            gleEstacion.SelectedIndex = 0;
            gleProducto.SelectedIndex = 0;
            gleMonedero.SelectedIndex = 0;
            hfId["idCliente"] = gleEmpresa.Value == null? -1:gleEmpresa.Value;
        }
    }

    private void PermanentConfig()
    {

        if (!_oConsumoCombustibleDAL.PoseeEmpresasDeDescuento(User.Identity.Name,hfId["idCliente"].ToString()))
        {
            gvReportDataDetallado.Columns["VALOR_DESCUENTO"].Visible = false;
            gvReportDataDetallado.Columns["VALOR_DESCUENTO"].ShowInCustomizationForm = false;

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

    public void CargarDatosEmpresa()
    {

        gleEmpresa.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Empresas"];
        gleEmpresa.DataBind();

        foreach (ListEditItem item in gleEmpresa.Items)
        {
            if (item.Value.ToString() == "0")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    public void CargarDatosFuente()
    {
        gleFuente.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Fuente"];
        gleFuente.DataBind();

        foreach (ListEditItem item in gleFuente.Items)
        {
            if (item.Value.ToString() == "-1")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    public void CargarDatosTipoCliente()
    {
        gleTipo.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.TipoCliente"];
        gleTipo.DataBind();

        foreach (ListEditItem item in gleTipo.Items)
        {
            if (item.Value.ToString() == "T")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    public void CargarDatosEstaciones()
    {
        gleEstacion.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Estaciones"];
        gleEstacion.DataBind();

        foreach (ListEditItem item in gleEstacion.Items)
        {
            if (item.Value.ToString() == "0")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }
    public void CargarDatosProductos()
    {
        gleProducto.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.Productos"];
        gleProducto.DataBind();

        foreach (ListEditItem item in gleProducto.Items)
        {
            if (item.Value.ToString() == "-1")
            {
                item.ImageUrl = "~/app/Images/ckeck-24.png";
            }
        }
    }

    public void CargarDatosTipoProductos()
    {
        gleMonedero.DataSource = Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.TipoProductos"];
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



    protected void gvReportDataDetallado_Init(object sender, EventArgs e)
    {
      //  gvReportDataDetallado.Templates.GroupRowContent = new GridGroupRowContentTemplate();
    }

    protected void gleMonedero_Callback(object sender, CallbackEventArgsBase e)
    {
        Session[hfId["sessionId"] + "dxConsumoCombustibleDetallado.TipoProductos"] = dalEmpresa.ObtenerTipoMonederosXEmpresaUsuario(conexion, User.Identity.Name,true, gleEmpresa.Value == null ? -100 : (int)gleEmpresa.Value);
        CargarDatosTipoProductos();
        //if (((DataTable)gleProducto.DataSource).Rows.Count>0)
        gleMonedero.SelectedIndex = 0;
    }

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


}