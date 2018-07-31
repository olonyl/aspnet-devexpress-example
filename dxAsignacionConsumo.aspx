<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="dxAsignacionConsumo.aspx.cs"
    MasterPageFile="~/app/disenio/SiteMenu.master" Inherits="app_suscripcion_dxAsignacionConsumo" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="js/dxAsignacionConsumo.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <div style="min-width: 650px">
        <div class="system-form" style="margin-top: 5px; padding-top: 5px">
            <dx:ASPxGridViewExporter ID="gridExportDetallado" runat="server" GridViewID="gvReportSaldoTarjeta">
            </dx:ASPxGridViewExporter>
            <dx:ASPxGridViewExporter ID="gridExportPopupDetalle" runat="server" GridViewID="gvDetalleSaldo">
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
                                    <dx:ASPxGridView ID="gvReportSaldoTarjeta" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvReportSaldoTarjeta" EnableTheming="True" Theme="Material" Width="100%" OnClientLayout="gvReportDataDetallado_ClientLayout" OnCustomCallback="gvReportDataDetallado_CustomCallback" KeyFieldName="IDVEHICULO" OnCustomJSProperties="gvReportDataDetallado_CustomJSProperties" OnInit="gvReportDataDetallado_Init">
                                        <Styles>
                                            <Header CssClass="gridHeader"></Header>

                                            <GroupRow CssClass="gridGroupRow"></GroupRow>

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
                                            <dx:ASPxSummaryItem FieldName="ASIGNADO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHADO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHADO_COR" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHADO_USD" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="SALDO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="ASIGNADOGLN" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHOGLN" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DISPONIBLEGLN" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                        </TotalSummary>
                                        <GroupSummary>
                                            <dx:ASPxSummaryItem FieldName="ASIGNADO" ShowInGroupFooterColumn="ASIGNADO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHADO" ShowInGroupFooterColumn="DESPACHADO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHADO_COR" ShowInGroupFooterColumn="DESPACHADO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHADO_USD" ShowInGroupFooterColumn="DESPACHADO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="SALDO" ShowInGroupFooterColumn="SALDO" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="ASIGNADOGLN" ShowInGroupFooterColumn="ASIGNADOGLN" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DESPACHOGLN" ShowInGroupFooterColumn="DESPACHOGLN" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                            <dx:ASPxSummaryItem FieldName="DISPONIBLEGLN" ShowInGroupFooterColumn="DISPONIBLEGLN" SummaryType="Sum" DisplayFormat="{0:#,0.000}" />
                                        </GroupSummary>
                                        <ClientSideEvents ColumnResized="Grid_ColumnResized" BeginCallback="BeginGridCallback" ColumnResizing="OnGrigColumnResizing" EndCallback="GridEndCallback" Init="OnInit" CallbackError="OnCallbackError" CustomButtonClick="CustomButtonClickEvent" />
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
                                        <SettingsText CustomizationWindowCaption="Selector de Campos" GroupPanel="Arrastrar una columna aquí para agupar por esa columna" Title="SALDO DE TARJETAS" />
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
                                            <dx:GridViewCommandColumn VisibleIndex="0" Name="CommandCol" AllowDragDrop="False" Caption=" " ShowClearFilterButton="True" ToolTip="Limpiar Filtros" Width="80px" FixedStyle="Left">
                                                <CustomButtons>
                                                    <dx:GridViewCommandColumnCustomButton ID="cbDetail" Text=" " Image-ToolTip="Visualizar Detalle de Saldo">
                                                        <Image IconID="reports_report_16x16office2013">
                                                        </Image>
                                                    </dx:GridViewCommandColumnCustomButton>
                                                </CustomButtons>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="Empresa" ShowInCustomizationForm="True" VisibleIndex="1"
                                                FieldName="CLIENTE" Width="180px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                                <Settings AllowEllipsisInText="True"></Settings>

                                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>

                                                <CellStyle Wrap="False"></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="División" ShowInCustomizationForm="True" VisibleIndex="2"
                                                FieldName="DIVISION" Width="140px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Sub División" ShowInCustomizationForm="True"
                                                VisibleIndex="3" FieldName="SUBDIVISION" Width="140px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Flota" ShowInCustomizationForm="True" VisibleIndex="4"
                                                FieldName="FLOTA" Width="140px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tarjeta" ShowInCustomizationForm="True" VisibleIndex="6"
                                                FieldName="TARJETA" Width="140px">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Vehículo" ShowInCustomizationForm="True" VisibleIndex="7"
                                                FieldName="VEHICULO" Width="200px">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Placa" ShowInCustomizationForm="True" VisibleIndex="8"
                                                FieldName="PLACA">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="PIN" ShowInCustomizationForm="True" VisibleIndex="9"
                                                FieldName="PIN">
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Centro de Costos" ShowInCustomizationForm="True" VisibleIndex="5"
                                                FieldName="CENTROCOSTO" Width="180px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Producto" ShowInCustomizationForm="True" VisibleIndex="11"
                                                FieldName="PRODUCTO" Width="100px">
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Asignado" ShowInCustomizationForm="True" VisibleIndex="12"
                                                FieldName="ASIGNADO">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000">
                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Despachado" ShowInCustomizationForm="True" VisibleIndex="14"
                                                FieldName="DESPACHADO" PropertiesTextEdit-DisplayFormatString="#,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Despachado (C$)" ShowInCustomizationForm="True" VisibleIndex="16"
                                                FieldName="DESPACHADO_COR" PropertiesTextEdit-DisplayFormatString="#,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                              <dx:GridViewDataTextColumn Caption="Despachado (USD)" ShowInCustomizationForm="True" VisibleIndex="16"
                                                FieldName="DESPACHADO_USD" PropertiesTextEdit-DisplayFormatString="#,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Disponible" ShowInCustomizationForm="True" VisibleIndex="17"
                                                FieldName="SALDO" PropertiesTextEdit-DisplayFormatString="C$ #,0.00" Width="130px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Asignado (gal)" ShowInCustomizationForm="True" VisibleIndex="13"
                                                FieldName="ASIGNADOGLN" PropertiesTextEdit-DisplayFormatString="C$ #,0.00" Width="150px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Despachado (gal)" ShowInCustomizationForm="True" VisibleIndex="15"
                                                FieldName="DESPACHOGLN" PropertiesTextEdit-DisplayFormatString="C$ #,0.00" Width="150px">

                                                <PropertiesTextEdit DisplayFormatString="#,0.000"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Disponible (gal)" ShowInCustomizationForm="True" VisibleIndex="18"
                                                FieldName="DISPONIBLEGLN" PropertiesTextEdit-DisplayFormatString="$ #,0.00" Width="150px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000"></PropertiesTextEdit>

                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Modalidad" ShowInCustomizationForm="True" VisibleIndex="10"
                                                FieldName="MONEDERO" Width="140px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000">
                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>

                                        </Columns>
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
                                    </dx:ASPxGridView>
                                </div>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                </Panes>
            </dx:ASPxSplitter>
        </div>
        <%-- Formulario de Detalle de Saldos --%>
        <dx:ASPxHiddenField ID="hfId" runat="server" ClientInstanceName="hfId">
        </dx:ASPxHiddenField>
        <%--Hidden Field--%>
        <%--Loading Panel--%>
        <dx:ASPxLoadingPanel ID="lpPrincipal" runat="server" ClientInstanceName="lpPrincipal"
            Modal="True" Theme="Material">
        </dx:ASPxLoadingPanel>
        <%-- Formulario de Filtros --%>
        <dx:ASPxPopupControl ID="popDatos" runat="server" FooterText="" HeaderText="Filtros del Reporte ( Saldo de Tarjetas )" Theme="Material" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" ShowFooter="True" Width="700px" ClientInstanceName="popDatos" Modal="True" CloseAction="CloseButton" PopupAnimationType="Fade" AutoUpdatePosition="True" ShowOnPageLoad="True" AllowDragging="True" PopupVerticalOffset="150">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <asp:Panel runat="server">
                        <div id="popUpEditControl">
                            <table class="tableControls">
                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Periodo:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px; width: 160px;">
                                        <dx:ASPxComboBox ID="gleMes" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleMes" SelectedIndex="0" ShowImageInEditBox="True" Theme="Material" ToolTip="Mes" ValueType="System.Int32" Width="100%">
                                            <ClientSideEvents DropDown="DropDownSelectAll"/>
                                            <Items>
                                                <dx:ListEditItem Selected="True" Text="ENERO" Value="1" />
                                                <dx:ListEditItem Text="FEBRERO" Value="2" />
                                                <dx:ListEditItem Text="MARZO" Value="3" />
                                                <dx:ListEditItem Text="ABRIL" Value="4" />
                                                <dx:ListEditItem Text="MAYO" Value="5" />
                                                <dx:ListEditItem Text="JUNIO" Value="6" />
                                                <dx:ListEditItem Text="JULIO" Value="7" />
                                                <dx:ListEditItem Text="AGOSTO" Value="8" />
                                                <dx:ListEditItem Text="SEPTIEMBRE" Value="9" />
                                                <dx:ListEditItem Text="OCTUBRE" Value="10" />
                                                <dx:ListEditItem Text="NOVIEMBRE" Value="11" />
                                                <dx:ListEditItem Text="DICIEMBRE" Value="12" />
                                            </Items>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Empresa es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Empresa es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td style="padding-right: 5px; width: 100px;">
                                        <dx:ASPxComboBox ID="gleAnio" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleAnio" ShowImageInEditBox="True" Theme="Material" ToolTip="Año" ValueType="System.Int32" Width="100%">
                                            <ClientSideEvents DropDown="DropDownSelectAll" />
                                            <Items>
                                                <dx:ListEditItem Text="2013" Value="2013" />
                                                <dx:ListEditItem Text="2014" Value="2014" />
                                                <dx:ListEditItem Text="2015" Value="2015" />
                                                <dx:ListEditItem Text="2016" Value="2016" />
                                                <dx:ListEditItem Text="2017" Value="2017" />
                                                <dx:ListEditItem Text="2018" Value="2018" />
                                                <dx:ListEditItem Text="2019" Value="2019" />
                                                <dx:ListEditItem Text="2020" Value="2020" />
                                                <dx:ListEditItem Text="2021" Value="2021" />
                                                <dx:ListEditItem Text="2022" Value="2022" />
                                                <dx:ListEditItem Text="2023" Value="2023" />
                                                <dx:ListEditItem Text="2024" Value="2024" />
                                                <dx:ListEditItem Text="2025" Value="2025" />
                                                <dx:ListEditItem Text="2026" Value="2026" />
                                                <dx:ListEditItem Text="2027" Value="2027" />
                                            </Items>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Empresa es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Empresa es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td style="padding-right: 5px; width: 65px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Tipo:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px;">
                                        <dx:ASPxComboBox ID="gleTipo" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleTipo" ShowImageInEditBox="True" TextField="DESCRIPCION" Theme="Material" ToolTip="Tipo de Empresa" ValueField="TIPO" Width="100%">
                                            <ClientSideEvents DropDown="DropDownSelectAll" SelectedIndexChanged="OnTypeChanged" />
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
                            </table>
                            <table class="tableControls">

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Empresa:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td colspan="3" style="padding-right: 5px;">
                                        <dx:ASPxComboBox ID="gleEmpresa" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleEmpresa" OnCallback="gleEmpresa_Callback" OnDataBound="gleEmpresa_DataBound" ShowImageInEditBox="True" TextField="Empresa" Theme="Material" ToolTip="Nombre de la Empresa" ValueField="IdEmpresa" ValueType="System.Int32" Width="100%">
                                            <ClientSideEvents CallbackError="OnCallbackError" DropDown="DropDownSelectAll" EndCallback="OnCompanyEndCallback" SelectedIndexChanged="OnClientChanged" />
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
                                        <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="Modalidad:" Theme="Material">
                                        </dx:ASPxLabel>

                                    </td>
                                    <td style="padding-right: 5px; width: 210px;">
                                        <dx:ASPxComboBox ID="gleTipoProducto" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleTipoProducto" SelectedIndex="0" ShowImageInEditBox="True" TextField="NOMBRE" Theme="Material" ToolTip="Tipo de Monedero" ValueField="ID" Width="100%" OnCallback="gleTipoProducto_Callback" OnDataBound="gleTipoProducto_DataBound">
                                            <ClientSideEvents CallbackError="OnCallbackError" EndCallback="OnTipoProductoEndCallback" DropDown="DropDownSelectAll" />
                                            <Items>
                                                <dx:ListEditItem ImageUrl="~/app/Images/gas-24.png" Text="COMBUSTIBLE" Value="C" Selected="True" />
                                                <dx:ListEditItem ImageUrl="~/app/Images/Money-24.png" Text="DINERO" Value="D" />
                                            </Items>
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="El Monedero es requerido" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="El Tipo de Monedero es requerido" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                        </dx:ASPxComboBox>

                                    </td>
                                    <td style="padding-right: 5px; width: 65px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Producto:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px;">
                                        <dx:ASPxComboBox ID="gleProducto" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleProducto" OnCallback="gleProducto_Callback" OnDataBound="gleProducto_DataBound" SelectedIndex="0" ShowImageInEditBox="True" TextField="NOMBRE" Theme="Material" ToolTip="Tipo de Producto" ValueField="ID" Width="100%">
                                            <ClientSideEvents CallbackError="OnCallbackError" DropDown="DropDownSelectAll" EndCallback="OnProductoEndCallback" />
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
        <%-- Formulario de Filtros --%>

        <%-- Formulario de Detalle de Saldos --%>
        <dx:ASPxPopupControl ID="popDetail" runat="server" FooterText="" HeaderText="Detalle de Saldos" Theme="Material" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" ShowFooter="True" Width="900px" ClientInstanceName="popDetail" Modal="True" CloseAction="CloseButton" PopupAnimationType="Fade" AutoUpdatePosition="True" AllowDragging="True" PopupVerticalOffset="50" Height="500px" OnWindowCallback="popDetail_WindowCallback">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <asp:Panel runat="server">
                        <div>
                            <table class="tableControls">

                                <tr class="TableRowHeight">
                                    <td style="text-align: right; padding-right: 5px;">
                                        <dx:ASPxGridView ID="gvDetalleSaldo" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvDetalleSaldo" EnableTheming="True" OnClientLayout="gvReportDataDetallado_ClientLayout" OnCustomCallback="gvReportDataDetallado_CustomCallback" OnCustomJSProperties="gvReportDataDetallado_CustomJSProperties" OnInit="gvReportDataDetallado_Init" Theme="Material" Width="100%">
                                            <ClientSideEvents BeginCallback="BeginGridCallback" CallbackError="OnCallbackError" ColumnResized="Grid_ColumnResized" ColumnResizing="OnGrigColumnResizing" CustomButtonClick="CustomButtonClickEvent" EndCallback="GridEndCallback" Init="OnInit" />
                                            <SettingsPager Mode="ShowAllRecords" PageSize="15">
                                                <Summary AllPagesText="Páginas: {0} - {1} ({2} registros)" EmptyText="No hay datos para paginar" Text="Página {0} de {1} ({2} registros)" />
                                            </SettingsPager>
                                            <Settings ShowFilterRow="True" ShowFooter="True" ShowHeaderFilterButton="True" ShowTitlePanel="True" VerticalScrollableHeight="250" VerticalScrollBarMode="Auto" />
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
                                            <SettingsText CustomizationWindowCaption="Selector de Campos" GroupPanel="Arrastrar una columna aquí para agupar por esa columna" Title="DETALLE DE SALDO" />
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
                                                <dx:GridViewDataTextColumn Caption="Tipo" ShowInCustomizationForm="True" VisibleIndex="1" Width="100px" FieldName="TIPO">
                                                    <Settings AllowEllipsisInText="True" />
                                                    <SettingsHeaderFilter Mode="CheckedList">
                                                    </SettingsHeaderFilter>
                                                    <CellStyle Wrap="False" HorizontalAlign="Left">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Usuario" FieldName="USUARIO" ShowInCustomizationForm="True" VisibleIndex="4" Width="140px">
                                                    <Settings AllowEllipsisInText="True" />
                                                    <SettingsHeaderFilter Mode="CheckedList">
                                                    </SettingsHeaderFilter>
                                                    <CellStyle HorizontalAlign="Left">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Estación" ShowInCustomizationForm="True" VisibleIndex="5" Width="200px" FieldName="ESTACION">
                                                    <Settings AllowEllipsisInText="True" />
                                                    <SettingsHeaderFilter Mode="CheckedList">
                                                    </SettingsHeaderFilter>
                                                    <CellStyle Wrap="False" HorizontalAlign="Left">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Monto" ShowInCustomizationForm="True" VisibleIndex="3" Width="130px" FieldName="MONTO_3">
                                                    <PropertiesTextEdit DisplayFormatString="#,0.000">
                                                    </PropertiesTextEdit>
                                                    <Settings AllowEllipsisInText="True" />
                                                    <CellStyle Wrap="False">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataCheckColumn Caption="VOX?" ShowInCustomizationForm="True" VisibleIndex="0" Width="70px" FieldName="VOX">
                                                    <PropertiesCheckEdit>
                                                        <DisplayImageChecked IconID="actions_apply_16x16">
                                                        </DisplayImageChecked>
                                                        <DisplayImageUnchecked IconID="actions_remove_16x16">
                                                        </DisplayImageUnchecked>
                                                        <DisplayImageUndefined Height="0px" IconID="trendlines_trendnone_16x16" Width="0px">
                                                        </DisplayImageUndefined>
                                                        <DisplayImageGrayed Height="0px" IconID="trendlines_trendnone_16x16" Width="0px">
                                                        </DisplayImageGrayed>
                                                    </PropertiesCheckEdit>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </dx:GridViewDataCheckColumn>
                                                <dx:GridViewDataTextColumn Caption="Fecha" ShowInCustomizationForm="True" VisibleIndex="2" Width="150px" FieldName="FECHA">
                                                    <Settings AllowEllipsisInText="True" />
                                                    <SettingsHeaderFilter Mode="CheckedList">
                                                    </SettingsHeaderFilter>
                                                    <CellStyle Wrap="False" HorizontalAlign="Left">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataCheckColumn Caption="Procesada" ShowInCustomizationForm="True" VisibleIndex="6" Width="90px" FieldName="PROCESADA">
                                                    <PropertiesCheckEdit>
                                                        <DisplayImageChecked IconID="conditionalformatting_iconsetsigns3_16x16">
                                                        </DisplayImageChecked>
                                                        <DisplayImageUnchecked IconID="conditionalformatting_iconsetredtoblack4_16x16">
                                                        </DisplayImageUnchecked>
                                                        <DisplayImageUndefined Height="0px" IconID="trendlines_trendnone_16x16" Width="0px">
                                                        </DisplayImageUndefined>
                                                        <DisplayImageGrayed Height="0px" IconID="trendlines_trendnone_16x16" Width="0px">
                                                        </DisplayImageGrayed>
                                                    </PropertiesCheckEdit>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </dx:GridViewDataCheckColumn>
                                            </Columns>
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem DisplayFormat="{0:Saldo: #,0.000}" FieldName="MONTO_3" SummaryType="Sum" />
                                            </TotalSummary>
                                            <Styles>
                                                <Header CssClass="gridHeader">
                                                </Header>
                                                <GroupRow CssClass="gridGroupRow">
                                                </GroupRow>
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
                                        </dx:ASPxGridView>
                                    </td>
                                </tr>

                            </table>
                            <hr style="padding: 0px; margin: 0px" />
                        </div>
                    </asp:Panel>

                </dx:PopupControlContentControl>
            </ContentCollection>
            <ClientSideEvents CallbackError="OnCallbackError" EndCallback="EndCallBackDetailPopUp" />
            <HeaderStyle CssClass="PopUpHeader">
                <Paddings PaddingBottom="8px" PaddingTop="8px" />
                <BorderBottom BorderColor="#E5E8EC" BorderStyle="Solid" BorderWidth="1px" />
            </HeaderStyle>
            <SettingsLoadingPanel Enabled="False" />
            <FooterContentTemplate>
                <table>
                    <tr>
                        <td style="width: 100%"></td>
                        <td></td>
                        <td style="width: 50px">
                            <dx:ASPxButton ID="btnExport" runat="server" AutoPostBack="false" Width="50" Text="Exportar" Theme="Material" ToolTip="Exportar a Excel" BackColor="#4CAF50" UseSubmitBehavior="False" ValidationGroup="NoGroup" OnClick="btnExport_Click">
                            </dx:ASPxButton>
                        </td>
                        <td style="padding-left: 10px">
                            <dx:ASPxButton ID="btnCancelDetail" runat="server" AutoPostBack="false" Text="Cerrar" Width="50" Theme="Material" BackColor="#f44336" UseSubmitBehavior="false" ValidationGroup="NoGroup">
                                <ClientSideEvents Click="CloseDetailPopUp" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </FooterContentTemplate>
            <HeaderImage IconID="reports_report_16x16office2013">
            </HeaderImage>
        </dx:ASPxPopupControl>
        <%-- Formulario de Detalle de Saldos --%>
    </div>
</asp:Content>
