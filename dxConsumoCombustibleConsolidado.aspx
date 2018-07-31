<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="dxConsumoCombustibleConsolidado.aspx.cs"
    MasterPageFile="~/app/disenio/SiteMenu.master" Inherits="app_suscripcion_dxConsumoCombustibleConsolidado" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">

    <script src="js/dxConsumoCombustibleConsolidado.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <div style="min-width: 650px" id="containtePrincipal">
        <div class="system-form" style="margin-top: 5px; padding-top: 5px">
            <dx:ASPxPivotGridExporter ID="gridExportConsolidado" runat="server" ASPxPivotGridID="pgReportDataConsolidado">
                <OptionsPrint PrintDataHeaders="True" PrintFilterHeaders="True" PrintHeadersOnEveryPage="True">
                    <PageSettings Landscape="True" />
                </OptionsPrint>
            </dx:ASPxPivotGridExporter>
            <dx:ASPxGridViewExporter ID="gridExportDetallado" runat="server" FileName="ConsumoConsolidadoPorVehiculo" GridViewID="gvReportDataDetallado">
            </dx:ASPxGridViewExporter>
            <dx:ASPxSplitter ID="splitter" runat="server" Orientation="Vertical" FullscreenMode="True"
                Height="100%" Width="100%" SeparatorVisible="False" Theme="Material" ClientInstanceName="splitter">
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
                                    <div id="containerConsoldiado" style="width: 100%; overflow-x: auto; white-space: nowrap;">
                                        <dx:ASPxPivotGrid ID="pgReportDataConsolidado" ClientInstanceName="pgReportDataConsolidado" runat="server" ClientIDMode="AutoID" Width="100%" Theme="Material" Height="100%" Font-Size="9pt" CustomizationFieldsLeft="600" CustomizationFieldsTop="400" OnClientLayout="pgReportDataConsolidado_ClientLayout" OnCustomCallback="pgReportDataConsolidado_CustomCallback" Caption="CONSUMO DE COMBUSTIBLE CONSOLIDADO POR JERARQUÍA" OnFieldValueDisplayText="pgReportDataConsolidado_FieldValueDisplayText">
                                            <Fields>
                                                <dx:PivotGridField Area="RowArea" AreaIndex="0" Caption="Empresa" FieldName="EMPRESA"
                                                    ID="fieldEmpreas" />
                                                <dx:PivotGridField Area="RowArea" AreaIndex="1" Caption="División" FieldName="DIVISION"
                                                    ID="fieldDivision" SortOrder="Descending">
                                                </dx:PivotGridField>
                                                <dx:PivotGridField Area="RowArea" AreaIndex="2" Caption="Sub División" FieldName="SUBDIVISION"
                                                    ID="fieldSubDivision" SortOrder="Descending">
                                                </dx:PivotGridField>
                                                <dx:PivotGridField Area="RowArea" AreaIndex="3" Caption="Flota" FieldName="FLOTA"
                                                    ID="fieldFlota" SortOrder="Descending">
                                                </dx:PivotGridField>
                                                <dx:PivotGridField Area="RowArea" AreaIndex="4" Caption="Combustible" FieldName="COMBUSTIBLE"
                                                    ID="fieldCombustible" SortOrder="Descending" Visible="false">
                                                </dx:PivotGridField>

                                                <dx:PivotGridField Area="RowArea" AreaIndex="5" Caption="Grupo de Facturación" FieldName="GRUPO_FACTURACION"
                                                    ID="fieldGrupoFacturacion" SortOrder="Descending" Visible="False">
                                                </dx:PivotGridField>
                                                <dx:PivotGridField Area="RowArea" AreaIndex="6" Caption="Región" FieldName="REGION"
                                                    ID="fieldRegion" SortOrder="Descending" Visible="false">
                                                </dx:PivotGridField>
                                                <dx:PivotGridField Area="RowArea" AreaIndex="7" Caption="Monedero" FieldName="MONEDERO"
                                                    ID="fieldMonedero" SortOrder="Descending" Visible="false">
                                                </dx:PivotGridField>


                                                <dx:PivotGridField Area="DataArea" AreaIndex="0" Caption="Litros" FieldName="LITROS"
                                                    ID="fieldExtended_Litros" CellFormat-FormatString="#,0.000" CellFormat-FormatType="Numeric" />
                                                <dx:PivotGridField Area="DataArea" AreaIndex="1" Caption="Galones" FieldName="GALONES"
                                                    ID="fieldExtended_Galone" CellFormat-FormatString="#,0.000" CellFormat-FormatType="Numeric" Visible="false" />
                                                <dx:PivotGridField Area="DataArea" AreaIndex="1" Caption="Sub Total (C$)" FieldName="SUBTOTAL_CORDOBAS"
                                                    ID="fieldSubTotalCordobas" CellFormat-FormatString="C$ #,0.00" CellFormat-FormatType="Numeric" />
                                                <dx:PivotGridField Area="DataArea" AreaIndex="2" Caption="Descuento (C$)" FieldName="DESCUENTO_CORDOBAS"
                                                    ID="fieldDescuentoCordobas" CellFormat-FormatString="C$ #,0.00" CellFormat-FormatType="Numeric" />
                                                <dx:PivotGridField Area="DataArea" AreaIndex="3" Caption="Total (C$)" FieldName="TOTAL_CORDOBAS"
                                                    ID="fieldTotalCordobas" CellFormat-FormatString="C$ #,0.00" CellFormat-FormatType="Numeric" />
                                                <dx:PivotGridField Area="DataArea" AreaIndex="5" Caption="Sub Total ($)" FieldName="SUBTOTAL_DOLARES"
                                                    ID="fieldSubTotalDolares" CellFormat-FormatString="$ #,0.00" CellFormat-FormatType="Numeric" Visible="False" />
                                                <dx:PivotGridField Area="DataArea" AreaIndex="6" Caption="Descuento ($)" FieldName="DESCUENTO_DOLARES"
                                                    ID="fieldDescuentoDolares" CellFormat-FormatString="$ #,0.00" CellFormat-FormatType="Numeric" Visible="False" />
                                                <dx:PivotGridField Area="DataArea" AreaIndex="7" Caption="Total ($)" FieldName="TOTAL_DOLARES"
                                                    ID="fieldTotalDolares" CellFormat-FormatString="$ #,0.00" CellFormat-FormatType="Numeric" Visible="False" />
                                            </Fields>
                                            <ClientSideEvents EndCallback="GridEndCallback" CallbackError="OnCallbackError" />
                                            <OptionsView HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" ShowContextMenus="False" DataHeadersDisplayMode="Popup" RowTotalsLocation="Near" ShowDataHeaders="False" />
                                            <OptionsCustomization CustomizationWindowHeight="250" CustomizationExcelWindowHeight="250" CustomizationExcelWindowWidth="300" FilterPopupWindowHeight="250px" FilterPopupWindowMinHeight="250px" FilterPopupWindowMinWidth="150px" FilterPopupWindowWidth="150px" />
                                            <OptionsPager EnableAdaptivity="True" Visible="False">
                                            </OptionsPager>

                                            <OptionsFilter NativeCheckBoxes="False" />
                                            <Styles>
                                                <AreaStyle Font-Size="9pt">
                                                </AreaStyle>
                                                <CellStyle Font-Size="9pt">
                                                </CellStyle>
                                                <CustomizationFieldsContentStyle Font-Size="12pt">
                                                    <Paddings Padding="4px" />
                                                </CustomizationFieldsContentStyle>
                                                <CustomizationFieldsHeaderStyle Font-Size="12pt" ForeColor="#5F90C1">
                                                    <Paddings Padding="8px" />
                                                </CustomizationFieldsHeaderStyle>
                                                <CellsAreaStyle Font-Size="9pt">
                                                </CellsAreaStyle>

                                            </Styles>

                                        </dx:ASPxPivotGrid>
                                    </div>
                                    <dx:ASPxGridView ID="gvReportDataDetallado" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvReportDataDetallado" EnableTheming="True" Theme="Material" Width="100%" OnClientLayout="gvReportDataDetallado_ClientLayout" OnCustomCallback="gvReportDataDetallado_CustomCallback" KeyFieldName="ID">
                                        <ClientSideEvents ColumnResizing="OnGrigColumnResizing" EndCallback="GridEndCallbackDetail" Init="OnInit" CallbackError="OnCallbackError" />

                                        <SettingsPager PageSize="15">
                                            <Summary AllPagesText="Páginas: {0} - {1} ({2} registros)" EmptyText="No hay datos para paginar" Text="Página {0} de {1} ({2} registros)" />
                                        </SettingsPager>
                                        <Settings HorizontalScrollBarMode="Visible" ShowFilterRow="True" ShowGroupPanel="True" ShowHeaderFilterButton="True" ShowTitlePanel="True" VerticalScrollableHeight="0" VerticalScrollBarMode="Auto" ShowGroupFooter="VisibleAlways" />
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
                                        <SettingsText CustomizationWindowCaption="Selector de Campos" GroupPanel="Arrastrar una columna aquí para agupar por esa columna" Title="CONSOLIDADO DE CONSUMO DE COMBUSTIBLE POR VEHÍCULO" />
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
                                            <dx:GridViewDataTextColumn Caption="Empresa" FieldName="EMPRESA" ShowInCustomizationForm="True" VisibleIndex="1" Width="180px" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="División" FieldName="DIVISION" ShowInCustomizationForm="True" VisibleIndex="2" Width="140px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Subdivisión" FieldName="SUBDIVISION" ShowInCustomizationForm="True" VisibleIndex="3" Width="140px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Flota" FieldName="FLOTA" ShowInCustomizationForm="True" VisibleIndex="4" Width="140px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Centro de Costos" FieldName="CENTRO_COSTO" ShowInCustomizationForm="True" VisibleIndex="5" Width="180px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Grupo de Facturación" FieldName="GRUPO_FACTURACION" ShowInCustomizationForm="True" VisibleIndex="6" Width="170px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Región" FieldName="REGION" ShowInCustomizationForm="True" VisibleIndex="7" Width="140px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Vehículo" FieldName="VEHICULO" ShowInCustomizationForm="True" VisibleIndex="8" Width="200px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tarjeta" FieldName="TARJETA" ShowInCustomizationForm="True" VisibleIndex="9" Width="140px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Placa" FieldName="PLACA" ShowInCustomizationForm="True" VisibleIndex="10">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="PIN" FieldName="PIN" ShowInCustomizationForm="True" VisibleIndex="11">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Combustible" FieldName="COMBUSTIBLE" ShowInCustomizationForm="True" VisibleIndex="12" Width="140px">
                                                <Settings AllowEllipsisInText="True" AutoFilterCondition="Contains" />
                                                <SettingsHeaderFilter Mode="CheckedList">
                                                </SettingsHeaderFilter>
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Litros" FieldName="LITROS" ShowInCustomizationForm="True" VisibleIndex="13" Width="100px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000">

                                                    <MaskSettings Mask="#,0.000" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Galones" FieldName="GALONES" ShowInCustomizationForm="True" VisibleIndex="14" Visible="False" Width="100px">
                                                <PropertiesTextEdit DisplayFormatString="#,0.000">

                                                    <MaskSettings Mask="#,0.000" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Sub Total (C$)" FieldName="SUBTOTAL_CORDOBAS" ShowInCustomizationForm="True" VisibleIndex="15" Width="140px">
                                                <PropertiesTextEdit DisplayFormatString="C$ #,0.00">

                                                    <MaskSettings Mask="#,0.00" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Descuento (C$)" FieldName="DESCUENTO_CORDOBAS" ShowInCustomizationForm="True" VisibleIndex="16" Width="140px">
                                                <PropertiesTextEdit DisplayFormatString="C$ #,0.00">

                                                    <MaskSettings Mask="#,0.00" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Total (C$)" FieldName="TOTAL_CORDOBAS" ShowInCustomizationForm="True" VisibleIndex="17" Width="140px">
                                                <PropertiesTextEdit DisplayFormatString="C$ #,0.00">

                                                    <MaskSettings Mask="#,0.00" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Sub Total ($)" FieldName="SUBTOTAL_DOLARES" ShowInCustomizationForm="True" VisibleIndex="18" Visible="False" Width="140px">
                                                <PropertiesTextEdit DisplayFormatString="$ #,0.00">

                                                    <MaskSettings Mask="#,0.00" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Descuento ($)" FieldName="DESCUENTO_DOLARES" ShowInCustomizationForm="True" VisibleIndex="19" Visible="False" Width="140px">
                                                <PropertiesTextEdit DisplayFormatString="$ #,0.00">

                                                    <MaskSettings Mask="#,0.00" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
                                                <CellStyle Wrap="False">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Total ($)" FieldName="TOTAL_DOLARES" ShowInCustomizationForm="True" VisibleIndex="20" Visible="False" Width="140px">
                                                <PropertiesTextEdit DisplayFormatString="$ #,0.00">

                                                    <MaskSettings Mask="#,0.00" />

                                                </PropertiesTextEdit>
                                                <Settings AllowEllipsisInText="True" AllowHeaderFilter="False" ShowFilterRowMenu="True" />
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
                                            <Header CssClass="gridHeader" />
                                            <GroupRow CssClass="gridGroupRow" />
                                        </Styles>
                                        <Settings ShowGroupPanel="True" ShowFooter="True" />
                                        <TotalSummary>
                                            <dx:ASPxSummaryItem FieldName="TOTAL_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="SUBTOTAL_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="DESCUENTO_CORDOBAS" SummaryType="Sum" DisplayFormat="{0:C$ #,0.00}" />
                                            <dx:ASPxSummaryItem FieldName="VEHICULO" SummaryType="Count" DisplayFormat="{0:Cantidad: #,0}" />
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
                                            <dx:ASPxSummaryItem FieldName="VEHICULO" ShowInGroupFooterColumn="VEHICULO" SummaryType="Count" DisplayFormat="{0:Cantidad: #,0}" />
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
        <%--Loading Panel--%>
        <%-- Formulario de Edición de Registro --%>
        <dx:ASPxPopupControl ID="popDatos" runat="server" FooterText="" HeaderText="Filtros del Reporte ( Consolidado de Consumo )" Theme="Material" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" ShowFooter="True" Width="500px" ClientInstanceName="popDatos" Modal="True" CloseAction="CloseButton" PopupAnimationType="Fade" AutoUpdatePosition="True" ShowOnPageLoad="True" AllowDragging="True" PopupVerticalOffset="100">
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
                                    <td colspan="3">
                                        <dx:ASPxRadioButtonList ID="rbTipoFecha" runat="server" Theme="Material" RepeatDirection="Horizontal" ClientInstanceName="rbTipoFecha" SelectedIndex="1">
                                            <Items>
                                                <dx:ListEditItem Value="T" Text="Transacción" Selected="True" />
                                                <dx:ListEditItem Value="P" Text="Proceso" />
                                            </Items>
                                            <Border BorderStyle="None" />
                                        </dx:ASPxRadioButtonList>
                                    </td>

                                </tr>

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Inicio:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px; width: 160px;">
                                        <dx:ASPxDateEdit ID="deInicio" runat="server" AllowNull="False" ClientInstanceName="deInicio" PopupVerticalAlign="Middle" Theme="Material" ToolTip="Fecha Inicial" UseMaskBehavior="True" Width="100%" CalendarProperties-ShowWeekNumbers="False">
                                            <ClientSideEvents Init="OnDateEditInit" />
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Fecha Inicial es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Fecha Inicial es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                            <CalendarProperties ShowWeekNumbers="False">
                                                <MonthGridPaddings Padding="0px" />
                                                <DayStyle>
                                                    <Paddings Padding="5px" />
                                                </DayStyle>
                                                <DaySelectedStyle Font-Size="9pt">
                                                </DaySelectedStyle>
                                            </CalendarProperties>
                                        </dx:ASPxDateEdit>
                                    </td>
                                    <td style="padding-right: 5px; width: 60px; text-align: right;">
                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Fin:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px;">
                                        <dx:ASPxDateEdit ID="deFinal" runat="server" AllowNull="False" ClientInstanceName="deFinal" PopupVerticalAlign="Middle" Theme="Material" ToolTip="Fecha Final" UseMaskBehavior="True" Width="160px" CalendarProperties-ShowWeekNumbers="False">
                                            <ClientSideEvents Init="OnDateEditInit" />
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Fecha Final es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Fecha Final es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                            <CalendarProperties ShowWeekNumbers="False">
                                                <MonthGridPaddings Padding="0px" />
                                                <DayStyle>
                                                    <Paddings Padding="5px" />
                                                </DayStyle>
                                                <DaySelectedStyle Font-Size="9pt">
                                                </DaySelectedStyle>
                                            </CalendarProperties>
                                        </dx:ASPxDateEdit>
                                    </td>
                                </tr>

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Visualización:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td colspan="3" style="padding-right: 5px;">
                                        <dx:ASPxComboBox ID="gleJerarquia" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleJerarquia" TextField="Descripcion" Theme="Material" ValueField="IdIndustria" ValueType="System.String" Width="100%" SelectedIndex="0" ShowImageInEditBox="True" ToolTip="Tipo de Reporte a ser mostrado">
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Visualización es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Visualización es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                            <ClientSideEvents DropDown="DropDownSelectAll" />
                                            <Items>
                                                <dx:ListEditItem Text="Jerarquía" Value="J" Selected="True" ImageUrl="~/app/Images/organization-24.png" />
                                                <dx:ListEditItem Text="Vehículo" Value="V" ImageUrl="~/app/Images/vihicle-24.png" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </td>

                                </tr>

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Tipo:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td colspan="3" style="padding-right: 5px;">
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

                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Empresa:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="padding-right: 5px;" colspan="3">
                                        <dx:ASPxComboBox ID="gleEmpresa" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleEmpresa" TextField="Empresa" Theme="Material" ValueField="IdEmpresa" ValueType="System.Int32" Width="100%" ToolTip="Nombre de la Empresa" ShowImageInEditBox="True" OnCallback="gleEmpresa_Callback" OnDataBound="gleEmpresa_DataBound">
                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ErrorText="La Empresa es requerida" SetFocusOnError="True" ValidationGroup="gvDatos">
                                                <ErrorImage Url="../Images/validation_error.png">
                                                </ErrorImage>
                                                <RequiredField ErrorText="La Empresa es requerida" IsRequired="True" />
                                            </ValidationSettings>
                                            <InvalidStyle BackColor="#FFEBEE" Border-BorderColor="#FFCDD2">
                                            </InvalidStyle>
                                            <ClientSideEvents DropDown="DropDownSelectAll" EndCallback="OnCompanyEndCallback" CallbackError="OnCallbackError" SelectedIndexChanged="OnClientChanged" />
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>
                                <tr class="TableRowHeight">
                                    <td style="width: 90px; text-align: right; padding-right: 5px;">
                                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Modalidad:" Theme="Material">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td colspan="3" style="padding-right: 5px;">
                                        <dx:ASPxComboBox ID="gleMonedero" runat="server" AutoResizeWithContainer="True" ClientInstanceName="gleMonedero" SelectedIndex="0" ShowImageInEditBox="True" TextField="NOMBRE" Theme="Material" ToolTip="Tipo de Monedero" ValueField="ID" Width="100%" OnCallback="gleMonedero_Callback" OnDataBound="gleMonedero_DataBound">
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
                                            <ClientSideEvents DropDown="DropDownSelectAll" CallbackError="OnCallbackError" EndCallback="OnMonederoEndCallback" />
                                        </dx:ASPxComboBox>
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
    </div>

</asp:Content>
