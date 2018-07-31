<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="dxConsumoCombustibleDetallado.aspx.cs"
    MasterPageFile="~/app/disenio/SiteMenu.master" Inherits="app_suscripcion_dxConsumoCombustibleDetallado" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="js/dxConsumoCombustibleDetallado.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <div style="min-width: 650px">
        <div class="system-form" style="margin-top: 5px; padding-top: 5px">
            <dx:ASPxGridViewExporter ID="gridExportDetallado" runat="server" FileName="ConsumoConsolidadoPorVehiculo" GridViewID="gvReportDataDetallado">
            </dx:ASPxGridViewExporter>
            <dx:ASPxSplitter ID="ASPxSplitter1" runat="server" Orientation="Vertical" FullscreenMode="True"
                Height="100%" Width="100%" SeparatorVisible="False" Theme="Material">
                <ClientSideEvents PaneResized="OnSplitterPaneResized" />
                <Panes>
                    <dx:SplitterPane AutoHeight="True" Size="30px">
                        <ContentCollection>
                            <dx:SplitterContentControl runat="server">
                                <table width="100%">
                                    <tr>
                                        <td id="tdTitle" class="LabelEllipsisStyle">&nbsp;<dx:ASPxLabel ID="lblTitle" runat="server" ClientInstanceName="lblTitle" ForeColor="#003399" AllowEllipsisInText="True">
                                        </dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxMenu ID="menuPrincipal" runat="server" EnableTheming="True" ShowAsToolbar="True"
                                                ShowPopOutImages="True" Theme="iOS" ClientInstanceName="menuPrincipal" OnItemClick="menuPrincipal_ItemClick"
                                                EnableCallBacks="True">
                                                <ClientSideEvents ItemClick="ItemClickClientEvent" />
                                                <Items>
                                                    <dx:MenuItem Name="Filter" ToolTip="Mostrar Filtros">
                                                        <Image IconID="actions_filter_32x32devav">
                                                        </Image>
                                                    </dx:MenuItem>
                                                    <dx:MenuItem Name="ExportarXLS" ToolTip="Exportar a Excel">
                                                        <Image IconID="export_exporttoxls_32x32office2013">
                                                        </Image>
                                                    </dx:MenuItem>
                                                    <dx:MenuItem Name="ConfigurarLayout" BeginGroup="True" DropDownMode="True">
                                                        <Items>
                                                            <dx:MenuItem Name="PersonalizarGrid" Text="Editar Columnas" ToolTip="Seleccionar/Ocultar Columnas">
                                                                <Image IconID="actions_hideproduct_16x16devav">
                                                                </Image>
                                                            </dx:MenuItem>
                                                            <dx:MenuItem Name="GuardarLayout" Text="Guardar Layout" ToolTip="Guardar Layout"
                                                                BeginGroup="true">
                                                                <Image IconID="setup_savepagesetup_32x32office2013">
                                                                </Image>
                                                            </dx:MenuItem>
                                                            <dx:MenuItem Name="ReiniciarLayout" Text="Reiniciar Layout" ToolTip="Reiniciar Layout">
                                                                <Image IconID="reports_none_32x32office2013">
                                                                </Image>
                                                            </dx:MenuItem>
                                                        </Items>
                                                        <Image IconID="programming_ide_32x32office2013">
                                                        </Image>
                                                    </dx:MenuItem>
                                                </Items>
                                            </dx:ASPxMenu>
                                        </td>
                                        <td class="noBorders" id="chkExpandGridTD" style="width: 50px; border-width: 0px 0px 0px 1px; border-color: #DFDFDF; border-left-style: solid;">
                                            <dx:ASPxCheckBox ID="chkExpandGrid" ClientInstanceName="chkExpandGrid" runat="server" ToolTip="Colapsar/Expandir Grupos" CheckState="Checked" CssClass="noBorders">
                                                <CheckedImage IconID="spreadsheet_collapsefieldpivottable_32x32">
                                                </CheckedImage>
                                                <UncheckedImage IconID="spreadsheet_expandfieldpivottable_32x32">
                                                </UncheckedImage>
                                                <ClientSideEvents CheckedChanged="ExpandGroups" />
                                            </dx:ASPxCheckBox>
                                        </td>
                                    </tr>
                                </table>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                    <dx:SplitterPane>
                        <ContentCollection>
                            <dx:SplitterContentControl runat="server">
                                <div id="gridContainer">
                                    <dx:ASPxGlobalEvents ID="ge" runat="server">
                                        <ClientSideEvents ControlsInitialized="OnControlsInitialized" />
                                    </dx:ASPxGlobalEvents>
                                    <dx:ASPxGridView ID="gvReportDataDetallado" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvReportDataDetallado" EnableTheming="True" Theme="Material" Width="100%" OnClientLayout="gvReportDataDetallado_ClientLayout" OnCustomCallback="gvReportDataDetallado_CustomCallback" KeyFieldName="ID" OnCustomJSProperties="gvReportDataDetallado_CustomJSProperties" OnInit="gvReportDataDetallado_Init">
                                        <ClientSideEvents ColumnResized="Grid_ColumnResized" BeginCallback="BeginGridCallback" ColumnResizing="OnGrigColumnResizing" EndCallback="GridEndCallback" Init="OnInit" CallbackError="OnCallbackError" />
                                        <Styles>
                                            <Header CssClass="gridHeader" />
                                            <GroupRow CssClass="gridGroupRow" />

<FilterRow CssClass="customFilterRow"></FilterRow>

<Footer Font-Size="10pt"></Footer>

<PagerBottomPanel>
<Paddings Padding="4px"></Paddings>
</PagerBottomPanel>

<CommandColumn Spacing="2px" Wrap="False"></CommandColumn>

<FilterCell Font-Bold="False"></FilterCell>

<HeaderFilterItem Font-Size="9pt"></HeaderFilterItem>
                                        </Styles>
                                        <SettingsPager PageSize="15">
                                            <Summary AllPagesText="Páginas: {0} - {1} ({2} registros)" EmptyText="No hay datos para paginar" Text="Página {0} de {1} ({2} registros)" />
                                        </SettingsPager>
                                        <Settings HorizontalScrollBarMode="Visible" ShowFilterRow="True" ShowGroupPanel="True" ShowHeaderFilterButton="True" ShowTitlePanel="True" VerticalScrollableHeight="0" VerticalScrollBarMode="Auto" ShowFooter="True" ShowGroupFooter="VisibleAlways" />
                                        <SettingsBehavior AutoExpandAllGroups="True" EnableCustomizationWindow="True" />
                                        <SettingsCookies CookiesID="ASPxGridViewCookies" />
                                        <SettingsCommandButton>
                                            <ClearFilterButton ButtonType="Link" RenderMode="Link" Text="Limpiar">
                                            </ClearFilterButton>
                                        </SettingsCommandButton>
                                        <SettingsPopup>
                                            <CustomizationWindow Height="250px" HorizontalAlign="Center" VerticalAlign="Middle" Width="300px" />
                                            <HeaderFilter Height="300px" MinHeight="300px" MinWidth="100px" Width="100px" />
                                        </SettingsPopup>
                                        <SettingsText CustomizationWindowCaption="Selector de Campos" GroupPanel="Arrastrar una columna aquí para agupar por esa columna" Title="CONSUMO DE COMBUSTIBLE DETALLADO" />
                                        <StylesPopup>
                                            <CustomizationWindow>
                                                <Header Font-Size="12pt" ForeColor="#5F90C1">
                                                    <Paddings Padding="8px" PaddingBottom="8px" PaddingLeft="8px" PaddingRight="8px" PaddingTop="8px" />
                                                </Header>
                                            </CustomizationWindow>
                                            <HeaderFilter>
                                                <Content Font-Size="9pt">
                                                    <Paddings Padding="1px" />
                                                </Content>
                                                <Footer Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle">
                                                    <SizeGripPaddings Padding="2px" />
                                                    <Paddings Padding="3px" />
                                                </Footer>
                                                <Header Font-Size="12pt">
                                                    <Paddings Padding="2px" />
                                                </Header>
                                            </HeaderFilter>
                                        </StylesPopup>
                                        <Columns>
                                            <dx:GridViewDataCheckColumn Caption="VOX?" FieldName="VOX" ShowInCustomizationForm="True" VisibleIndex="1" Width="100px">
                                                <PropertiesCheckEdit>
                                                    
<DisplayImageChecked IconID="actions_apply_16x16">
                                                    </DisplayImageChecked>
                                                    

<DisplayImageUnchecked IconID="actions_remove_16x16">
                                                    </DisplayImageUnchecked>
                                                
</PropertiesCheckEdit>
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </dx:GridViewDataCheckColumn>
                                            <dx:GridViewDataTextColumn Caption="Fuente" ShowInCustomizationForm="True" VisibleIndex="2"
                                                FieldName="FUENTE" Width="130px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Región" ShowInCustomizationForm="True" VisibleIndex="3"
                                                FieldName="REGION" Width="100px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Estación" ShowInCustomizationForm="True" VisibleIndex="4"
                                                FieldName="ESTACION" Width="160px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn Caption="Departamento" ShowInCustomizationForm="True" VisibleIndex="5"
                                                FieldName="DEPARTAMENTO" Width="160px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn Caption="Municipio" ShowInCustomizationForm="True" VisibleIndex="6"
                                                FieldName="MUNICIPIO" Width="160px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn Caption="Terminal" ShowInCustomizationForm="True" VisibleIndex="7"
                                                FieldName="TERMINAL" Width="100px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Fecha de Transacción" ShowInCustomizationForm="True"
                                                VisibleIndex="8" FieldName="FECHA_TRANSACCION" Width="160px">
                                                <Settings AllowEllipsisInText="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Fecha de Proceso" ShowInCustomizationForm="True"
                                                VisibleIndex="9" FieldName="FECHA_PROCESO" Width="150px">
                                                <Settings AllowEllipsisInText="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn Caption="Empresa" ShowInCustomizationForm="True" VisibleIndex="10"
                                                FieldName="EMPRESA" Width="180px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="División" ShowInCustomizationForm="True" VisibleIndex="11"
                                                FieldName="DIVISION" Width="140px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Subdivisión" ShowInCustomizationForm="True" VisibleIndex="12"
                                                FieldName="SUBDIVISION" Width="140px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Flota" ShowInCustomizationForm="True" VisibleIndex="13"
                                                FieldName="FLOTA" Width="140px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tarjeta" ShowInCustomizationForm="True" VisibleIndex="14"
                                                FieldName="TARJETA" Width="140px">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" AutoFilterCondition="Contains" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Vehículo" ShowInCustomizationForm="True" VisibleIndex="15"
                                                FieldName="DESCRIPCION" Width="200px">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" AutoFilterCondition="Contains" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Placa" ShowInCustomizationForm="True" VisibleIndex="16"
                                                FieldName="PLACA">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" AutoFilterCondition="Contains" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="PIN" ShowInCustomizationForm="True" VisibleIndex="17"
                                                FieldName="PIN">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" AutoFilterCondition="Contains" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Cédula" ShowInCustomizationForm="True" VisibleIndex="18"
                                                FieldName="CEDULA" Width="140px">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" AutoFilterCondition="Contains" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Grupo de Facturación" ShowInCustomizationForm="True"
                                                VisibleIndex="19" FieldName="GRUPO_FACTURACION" Width="180px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Centro de Costos" ShowInCustomizationForm="True"
                                                VisibleIndex="20" FieldName="CENTRO_COSTO" Width="180px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tipo de Vehículo" ShowInCustomizationForm="True"
                                                VisibleIndex="21" FieldName="TIPO_VEHICULO" Width="150px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Marca" ShowInCustomizationForm="True" VisibleIndex="22"
                                                FieldName="MARCA">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Modelo" ShowInCustomizationForm="True" VisibleIndex="23"
                                                FieldName="MODELO">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn Caption="Modalidad" ShowInCustomizationForm="True" VisibleIndex="24"
                                                FieldName="TIPO_MONEDERO" Width="130px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Precio" ShowInCustomizationForm="True" VisibleIndex="25"
                                                FieldName="PRECIO">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Producto" ShowInCustomizationForm="True" VisibleIndex="26"
                                                FieldName="FUEL" Width="145px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Litros" ShowInCustomizationForm="True" VisibleIndex="27"
                                                FieldName="LITROS">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Galones" ShowInCustomizationForm="True" VisibleIndex="28"
                                                FieldName="GALONES">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                              <dx:GridViewDataTextColumn Caption="Descuento (gal)" ShowInCustomizationForm="True" VisibleIndex="29"
                                                FieldName="VALOR_DESCUENTO" PropertiesTextEdit-DisplayFormatString="#,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.00"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Sub Total (C$)" ShowInCustomizationForm="True" VisibleIndex="30"
                                                FieldName="SUBTOTAL_CORDOBAS" PropertiesTextEdit-DisplayFormatString="C$ #,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="C$ #,0.00"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Descuento (C$)" ShowInCustomizationForm="True" VisibleIndex="31"
                                                FieldName="DESCUENTO_CORDOBAS" PropertiesTextEdit-DisplayFormatString="C$ #,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="C$ #,0.00"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Total (C$)" ShowInCustomizationForm="True" VisibleIndex="32"
                                                FieldName="TOTAL_CORDOBAS" PropertiesTextEdit-DisplayFormatString="C$ #,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="C$ #,0.00"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Sub Total ($)" ShowInCustomizationForm="True" VisibleIndex="33"
                                                FieldName="SUBTOTAL_DOLARES" PropertiesTextEdit-DisplayFormatString="$ #,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="$ #,0.00"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Descuento ($)" ShowInCustomizationForm="True" VisibleIndex="34"
                                                FieldName="DESCUENTO_DOLARES" PropertiesTextEdit-DisplayFormatString="$ #,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="$ #,0.00"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Total ($)" ShowInCustomizationForm="True" VisibleIndex="35"
                                                FieldName="TOTAL_DOLARES" PropertiesTextEdit-DisplayFormatString="$ #,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="$ #,0.00"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Atiende" ShowInCustomizationForm="True" VisibleIndex="36"
                                                FieldName="CAJERO" Width="160px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Referencia" ShowInCustomizationForm="True" VisibleIndex="37"
                                                FieldName="REFERENCIA" Width="130px">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" AutoFilterCondition="Contains" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>

                                        </Columns>
                                        <Styles>
                                            <FilterRow CssClass="customFilterRow">
                                            </FilterRow>
                                            <Footer Font-Size="10pt">
                                            </Footer>
                                            <PagerBottomPanel>
                                                <Paddings Padding="4px" />
                                            </PagerBottomPanel>
                                            <CommandColumn Spacing="2px" Wrap="False">
                                            </CommandColumn>
                                            <FilterCell Font-Bold="False">
                                            </FilterCell>
                                            <HeaderFilterItem Font-Size="9pt">
                                            </HeaderFilterItem>
                                        </Styles>
                                        <TotalSummary>
                                            <dx:ASPxSummaryItem FieldName="TOTAL_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="SUBTOTAL_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="DESCUENTO_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="DESCRIPCION" SummaryType="Count" DisplayFormat="{0:Cantidad: #,0}" />
                                            <dx:ASPxSummaryItem FieldName="TOTAL_DOLARES" SummaryType="Sum" DisplayFormat="{0:$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="SUBTOTAL_DOLARES" SummaryType="Sum" DisplayFormat="{0:$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="DESCUENTO_DOLARES" SummaryType="Sum" DisplayFormat="{0:$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="LITROS" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="GALONES" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                        </TotalSummary>
                                        <GroupSummary>
                                            <dx:ASPxSummaryItem FieldName="TOTAL_CORDOBAS" ShowInGroupFooterColumn="TOTAL_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="SUBTOTAL_CORDOBAS" ShowInGroupFooterColumn="SUBTOTAL_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="DESCUENTO_CORDOBAS" ShowInGroupFooterColumn="DESCUENTO_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="DESCRIPCION" ShowInGroupFooterColumn="DESCRIPCION" SummaryType="Count" DisplayFormat="{0:Cantidad: #,0}" />
                                            <dx:ASPxSummaryItem FieldName="TOTAL_DOLARES" ShowInGroupFooterColumn="TOTAL_DOLARES" SummaryType="Sum" DisplayFormat="{0:$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="SUBTOTAL_DOLARES" ShowInGroupFooterColumn="SUBTOTAL_DOLARES" SummaryType="Sum" DisplayFormat="{0:$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="DESCUENTO_DOLARES" ShowInGroupFooterColumn="DESCUENTO_DOLARES" SummaryType="Sum" DisplayFormat="{0:$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="LITROS" ShowInGroupFooterColumn="LITROS" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="GALONES" ShowInGroupFooterColumn="GALONES" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                        </GroupSummary>
                                    </dx:ASPxGridView>
                                </div>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                </Panes>
            </dx:ASPxSplitter>
        </div>
        <%--Hidden Field--%>
        <dx:ASPxHiddenField ID="hfId" runat="server" ClientInstanceName="hfId">
        </dx:ASPxHiddenField>
        <%--Hidden Field--%>
        <%--Loading Panel--%>
        <dx:ASPxLoadingPanel ID="lpPrincipal" runat="server" ClientInstanceName="lpPrincipal"
            Modal="True" Theme="Material">
        </dx:ASPxLoadingPanel>
        <dx:ASPxPopupControl ID="popDatos" runat="server" FooterText="" HeaderText="Filtros del Reporte ( Consumo Detallado )" Theme="Material" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" ShowFooter="True" Width="700px" ClientInstanceName="popDatos" Modal="True" CloseAction="CloseButton" PopupAnimationType="Fade" AutoUpdatePosition="True" ShowOnPageLoad="True" AllowDragging="True" PopupVerticalOffset="100">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <asp:Panel runat="server">
                        <div id="popUpEditControl">
                            <table class="tableControls">
                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Fecha:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px; width: 210px;">
                                        <dx:ASPxRadioButtonList ID="rbTipoFecha" runat="server" ClientInstanceName="rbTipoFecha" RepeatDirection="Horizontal" SelectedIndex="0" Theme="Material">
                                            <Items>
                                                <dx:ListEditItem Selected="True" Text="Transacción" Value="T" />
                                                <dx:ListEditItem Text="Proceso" Value="P" />
                                            </Items>
                                            <Border BorderStyle="None" />
                                        </dx:ASPxRadioButtonList>
                                    </td>
                                    <td style="padding-right: 5px; width: 50px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Inicio:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px; width: 120px;">
                                        <dx:ASPxDateEdit ID="deInicio" runat="server" AllowNull="False" ClientInstanceName="deInicio" PopupVerticalAlign="Middle" Theme="Material" ToolTip="Fecha Inicial" UseMaskBehavior="True" Width="120px">
                                            <ClientSideEvents Init="OnDateEditInit" />
                                            <CalendarProperties ShowWeekNumbers="False">
                                                <MonthGridPaddings Padding="0px" />
                                                <DayStyle>
                                                    <Paddings Padding="5px" />
                                                </DayStyle>
                                                <DaySelectedStyle Font-Size="9pt">
                                                </DaySelectedStyle>
                                            </CalendarProperties>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Fecha Inicial es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Fecha Inicial es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxDateEdit>
                                    </td>
                                    <td style="padding-right: 5px; width: 30px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Fin:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px; margin-left: 40px;">
                                        <dx:ASPxDateEdit ID="deFinal" runat="server" AllowNull="False" ClientInstanceName="deFinal" PopupVerticalAlign="Middle" Theme="Material" ToolTip="Fecha Final" UseMaskBehavior="True" Width="120px">
                                            <ClientSideEvents Init="OnDateEditInit" />
                                            <CalendarProperties ShowWeekNumbers="False">
                                                <MonthGridPaddings Padding="0px" />
                                                <DayStyle>
                                                    <Paddings Padding="5px" />
                                                </DayStyle>
                                                <DaySelectedStyle Font-Size="9pt">
                                                </DaySelectedStyle>
                                            </CalendarProperties>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Fecha Final es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Fecha Final es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                            </table>
                            <table class="tableControls">

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Fuente:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px; width: 210px;">
                                        <dx:ASPxComboBox ID="gleFuente" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleFuente" ShowImageInEditBox="True" TextField="Petrolera" Theme="Material" ToolTip="Fuente de Consumo" ValueField="SOURCE_ID" ValueType="System.Int32" Width="100%">
                                            <ClientSideEvents DropDown="DropDownSelectAll" SelectedIndexChanged="OnSourceChanged" />
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Fuente es requerido" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Fuente es requerido" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>
                                    </td>

                                    <td style="padding-right: 5px; width: 65px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="Estación:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px;">
                                        <dx:ASPxComboBox ID="gleEstacion" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleEstacion" OnCallback="gleEstacion_Callback" ShowImageInEditBox="True" TextField="ESTACION" Theme="Material" ToolTip="Nombre de la Empresa" ValueField="ID" ValueType="System.Int32" Width="100%" OnDataBound="gleEstacion_DataBound">
                                            <ClientSideEvents CallbackError="OnCallbackError" DropDown="DropDownSelectAll" EndCallback="OnStationEndCallback" />
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Empresa es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Empresa es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>
                                    </td>

                                </tr>

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel runat="server" Text="Tipo:" Theme="Material" ID="ASPxLabel7"></dx:ASPxLabel>

                                    </td>
                                    <td style="padding-right: 5px; width: 210px;">
                                        <dx:ASPxComboBox runat="server" ShowImageInEditBox="True" TextField="DESCRIPCION" ValueField="TIPO" AutoResizeWithContainer="True" Width="100%" ClientInstanceName="gleTipo" Theme="Material" ToolTip="Tipo de Empresa" ID="gleTipo">
                                            <ClientSideEvents SelectedIndexChanged="OnTypeChanged" DropDown="DropDownSelectAll"></ClientSideEvents>

                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" ErrorText="La Empresa es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png"></ErrorImage>

                                                <RequiredField IsRequired="True" ErrorText="La Empresa es requerida"></RequiredField>
                                            </ValidationSettings>

                                            <InvalidStyle Border-BorderColor="#FFCDD2" BackColor="#FFEBEE"></InvalidStyle>
                                        </dx:ASPxComboBox>

                                    </td>

                                    <td style="padding-right: 5px; width: 65px; text-align: right;">
                                        <dx:ASPxLabel runat="server" Text="Empresa:" Theme="Material" ID="ASPxLabel5"></dx:ASPxLabel>

                                    </td>
                                    <td style="padding-right: 5px;">
                                        <dx:ASPxComboBox runat="server" ShowImageInEditBox="True" ValueType="System.Int32" TextField="Empresa" ValueField="IdEmpresa" AutoResizeWithContainer="True" Width="100%" ClientInstanceName="gleEmpresa" Theme="Material" ToolTip="Nombre de la Empresa" ID="gleEmpresa" OnCallback="gleEmpresa_Callback" OnDataBound="gleEmpresa_DataBound">
                                            <ClientSideEvents EndCallback="OnCompanyEndCallback" CallbackError="OnCallbackError" DropDown="DropDownSelectAll"  SelectedIndexChanged="OnClientChanged" ></ClientSideEvents>

                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" ErrorText="La Empresa es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png"></ErrorImage>

                                                <RequiredField IsRequired="True" ErrorText="La Empresa es requerida"></RequiredField>
                                            </ValidationSettings>

                                            <InvalidStyle Border-BorderColor="#FFCDD2" BackColor="#FFEBEE"></InvalidStyle>
                                        </dx:ASPxComboBox>

                                    </td>

                                </tr>

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel runat="server" Text="Modalidad:" Theme="Material" ID="ASPxLabel6"></dx:ASPxLabel>

                                    </td>
                                    <td style="padding-right: 5px; width: 210px;">
                                        <dx:ASPxComboBox ID="gleMonedero" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleMonedero" SelectedIndex="0" ShowImageInEditBox="True" TextField="NOMBRE" Theme="Material" ToolTip="Tipo de Monedero" ValueField="ID" Width="100%" OnCallback="gleMonedero_Callback" OnDataBound="gleMonedero_DataBound">
                                            <ClientSideEvents CallbackError="OnCallbackError" EndCallback="OnTipoProductoEndCallback" DropDown="DropDownSelectAll" />
                                            <Items>
                                                <dx:ListEditItem ImageUrl="~/app/Images/ckeck-24.png" Selected="True" Text="(TODOS)" Value="T" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/gas-24.png" Text="COMBUSTIBLE" Value="C" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/Money-24.png" Text="DINERO" Value="D" />
                                            </Items>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="El Tipo de Monedero es requerido" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="El Tipo de Monedero es requerido" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>

                                    </td>
                                    <td style="padding-right: 5px; width: 65px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Producto:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px;">
                                        <dx:ASPxComboBox ID="gleProducto" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleProducto" SelectedIndex="0" ShowImageInEditBox="True" TextField="Combustible" Theme="Material" ToolTip="Tipo de Producto" ValueField="IdCombustible" ValueType="System.Int32" Width="100%">
                                            <ClientSideEvents DropDown="DropDownSelectAll"/>
                                            <Items>
                                                <dx:ListEditItem ImageUrl="~/app/Images/ckeck-24.png" Selected="True" Text="(TODOS)" Value="0" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/gas-24.png" Selected="True" Text="COMBUSTIBLE" Value="0" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/Money-24.png" Selected="True" Text="DINERO" Value="0" />
                                            </Items>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="El Monedero es requerido" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="El Monedero es requerido" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>

                            </table>
                            <hr style="padding: 0px; margin: 0px" />
                            <table class="tableControls">
                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="Otro:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px; width: 210px;">
                                        <dx:ASPxComboBox ID="gleOtro" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleOtro" SelectedIndex="0" ShowImageInEditBox="True" TextField="Descripcion" Theme="Material" ToolTip="Tipo de Monedero" ValueField="IdIndustria" Width="100%">
                                            <ClientSideEvents DropDown="DropDownSelectAll" SelectedIndexChanged="OtroSelectIndexChanged" />
                                            <Items>
                                                <dx:ListEditItem ImageUrl="~/app/Images/ckeck-24.png" Selected="True" Text="(TODOS)" Value="T" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/text24.png" Text="DESCRIPCION" Value="D" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/card24.png" Text="TARJETA" Value="J" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/barcode-24.png" Text="PLACA" Value="P" />
                                            </Items>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="El Monedero es requerido" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="El Monedero es requerido" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td style="padding-right: 5px; width: 65px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="Valor:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px;">
                                        <dx:ASPxTextBox ID="txtValor" runat="server" ClientInstanceName="txtValor" MaxLength="20" Theme="Material" Width="100%">
                                            <DisabledStyle BackColor="WhiteSmoke">
                                            </DisabledStyle>
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>

                </dx:PopupControlContentControl>
            </ContentCollection>
            <HeaderStyle CssClass="PopUpHeader">
                <Paddings PaddingBottom="8px" PaddingTop="8px" />
                <BorderBottom BorderColor="#E5E8EC" BorderStyle="Solid" BorderWidth="1px" />
            </HeaderStyle>
            <SettingsLoadingPanel Enabled="False" />
            <FooterContentTemplate>
                <table>
                    <tr>
                        <td style="width: 100%"></td>
                        <td>
                            <dx:ASPxButton ID="btnOk" runat="server" AutoPostBack="false" Text="Mostrar" Width="50" Theme="Material" BackColor="#03A9F4" UseSubmitBehavior="False" ValidationGroup="gvDatos">
                                <ClientSideEvents Click="ShowDataGrid" />
                            </dx:ASPxButton>
                        </td>
                        <td style="width: 50px"></td>
                        <td style="padding-left: 10px">
                            <dx:ASPxButton ID="btnCancel" runat="server" AutoPostBack="false" Text="Cancelar" Width="50" Theme="Material" BackColor="#f44336" UseSubmitBehavior="false" ValidationGroup="NoGroup">
                                <ClientSideEvents Click="ClosePopUp" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </FooterContentTemplate>
            <HeaderImage IconID="filter_crossdatasourcefiltering_16x16office2013">
            </HeaderImage>
        </dx:ASPxPopupControl>
        <%-- Formulario de Edición de Registro --%>
        <%-- Formulario de Edición de Registro --%>
    </div>
</asp:Content>
