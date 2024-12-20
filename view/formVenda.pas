unit formVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  Vcl.Buttons, FireDAC.Comp.Client, FireDAC.DApt, vendaController;

type
  TvendaForm = class(TForm)
    pnlToolBar: TPanel;
    pnlPrincipal: TPanel;
    pnlSair: TPanel;
    pnlFooter: TPanel;
    pnlFinaliza: TPanel;
    Label1: TLabel;
    pnlCancela: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    imgCliente: TImage;
    Panel4: TPanel;
    lblCliente: TLabel;
    Panel5: TPanel;
    Image2: TImage;
    Label4: TLabel;
    pnlMenu: TPanel;
    Panel7: TPanel;
    imgDeletarVenda: TImage;
    Label5: TLabel;
    Panel8: TPanel;
    imgPesquisa: TImage;
    Label6: TLabel;
    pnlTotal: TPanel;
    pnlFundo: TPanel;
    pnlQuant: TPanel;
    pnlAddItens: TPanel;
    pnlItens: TPanel;
    pnlTitulo: TPanel;
    pnlEdit: TPanel;
    lblCod: TLabel;
    editCodigo: TEdit;
    lblNome: TLabel;
    lblQuant: TLabel;
    lblValor: TLabel;
    editNome: TEdit;
    editQuant: TEdit;
    editValor: TEdit;
    lblTotal: TLabel;
    lblVlrTotal: TLabel;
    DBGrid1: TDBGrid;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    lblQntItens: TLabel;
    lblNumItens: TLabel;
    SpeedButton1: TSpeedButton;
    procedure pnlSairClick(Sender: TObject);
    procedure pnlSairMouseEnter(Sender: TObject);
    procedure pnlSairMouseLeave(Sender: TObject);
    procedure pnlMenuMouseEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlFundoMouseEnter(Sender: TObject);
    procedure pnlMenuResize(Sender: TObject);
    procedure editQuantKeyPress(Sender: TObject; var Key: Char);
    procedure pnlCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure editNomeChange(Sender: TObject);
    procedure editNomeEnter(Sender: TObject);
    procedure editCodigoClick(Sender: TObject);
    procedure editCodigoEnter(Sender: TObject);
    procedure editNomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnlFinalizaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgClienteClick(Sender: TObject);
    procedure imgPesquisaClick(Sender: TObject);
    procedure imgDeletarVendaClick(Sender: TObject);
  private
    { Private declarations }
    FListBox : TListBox;
    FVenda   : TVendaController;
    procedure iniciaDataSet;
    procedure iniciaForm;
    procedure insereProduto; overload;
    procedure insereProduto(Codigo : Integer ; Nome : String ; Quant : Extended ; Vlr_Unit : Currency); overload;
    procedure carregaTotais;
    procedure pesquisaProduto;
    procedure criaListBox;
  public
    { Public declarations }
  end;

var
  vendaForm: TvendaForm;

implementation

{$R *.dfm}

uses dmFuncoes, formPesquisaCliente, dmDatabase, formPesquisaVenda;

procedure TvendaForm.carregaTotais;
var iNumItens : Integer;
    eQuant : Extended;
    cTotal : Currency;
begin
  eQuant    := 0;
  iNumItens := 0;
  cTotal    := 0;

  if not cdsItens.Active then
  begin
    ShowMessage('O ClientDataSet est� fechado.');
    Exit;
  end;
  if cdsItens.IsEmpty then
  begin
    ShowMessage('O ClientDataSet n�o cont�m nenhum registro.');
    Exit;
  end;
  // Salvar a posi��o atual do cursor do ClientDataSet
  cdsItens.DisableControls;  // Evita atualiza��es visuais durante a itera��o
  try
    cdsItens.First;  // Posiciona no primeiro registro
    cdsItens.FieldByName('VLR_TOTAL').ReadOnly := False;
    while not cdsItens.Eof do
    begin
      with cdsItens do
      begin
        inc(iNumItens);
        eQuant := eQuant + FieldByName('QUANTIDADE').AsFloat;
        cTotal := cTotal + (FieldByName('QUANTIDADE').AsFloat * FieldByName('VLR_UNIT').AsFloat);
        Edit;
        FieldByName('VLR_TOTAL').AsCurrency := FieldByName('QUANTIDADE').AsFloat * FieldByName('VLR_UNIT').AsFloat;
        Post;
      end;
      cdsItens.Next;  // Avan�a para o pr�ximo registro
    end;
  finally
    cdsItens.EnableControls;  // Restaura as atualiza��es visuais
    lblQntItens.Caption := 'QTD: ' + eQuant.ToString;
    lblNumItens.Caption := 'N� Itens: ' + iNumItens.ToString;
    lblVlrTotal.Caption := 'R$ '+CurrToStr(cTotal);
  end;
end;

procedure TvendaForm.criaListBox;
begin
  if Assigned(FListBox) then FreeAndNil(FListBox);
  if not Assigned(FListBox) then
  begin
    FListBox           := TListBox.Create(nil);
    FListBox.Parent    := pnlFundo;
    FListBox.OnKeyDown := ListBoxKeyDown;
    FListBox.Left      := editNome.Left;
    FListBox.Width     := editNome.Width;
    FListBox.Top       := pnlEdit.Height;//editNome.Height + editNome.Top + 10;
  end;
end;

procedure TvendaForm.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not cdsItens.IsEmpty then
  begin
    // Verifica se a tecla pressionada foi Delete
    if Key = VK_DELETE then
    begin
      if MessageDlg('Deseja excluir o item?', mtConfirmation,
         [mbYes, mbNo], 0) = mrYes then
      begin
        cdsItens.Delete;
        carregaTotais;
      end;
    end;

    // Verifica se a tecla pressionada foi Enter
    if Key = VK_RETURN then
    begin
      begin
        cdsItens.Edit;
        // Libera os campos "QUANT" e "VLR_UNIT" para edi��o
        cdsItens.FieldByName('QUANTIDADE').ReadOnly := False;
        cdsItens.FieldByName('VLR_UNIT').ReadOnly := False;
        // Bloqueia outros campos
        cdsItens.FieldByName('CODIGO').ReadOnly    := True;
        cdsItens.FieldByName('NOME').ReadOnly      := True;
        cdsItens.FieldByName('VLR_TOTAL').ReadOnly := True;
        // Coloca o foco no campo "QUANTIDADE" para iniciar a edi��o
        DBGrid1.SelectedField := cdsItens.FieldByName('QUANTIDADE');
        // Anula a tecla.
        Key := 0;
      end;
    end;
  end;
end;

procedure TvendaForm.editCodigoClick(Sender: TObject);
begin
  editNome.SetFocus;
end;

procedure TvendaForm.editCodigoEnter(Sender: TObject);
begin
  editNome.SetFocus;
end;

procedure TvendaForm.editNomeChange(Sender: TObject);
begin
  if Trim(editNome.Text) = '' then
  begin
    if Assigned(FListBox) then FreeAndNil(FListBox);    
    Exit;
  end;
  pesquisaProduto;
end;

procedure TvendaForm.editNomeEnter(Sender: TObject);
begin
  editNome.SelectAll;
end;

procedure TvendaForm.editNomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DOWN) and Assigned(FListBox) then FListBox.SetFocus;
end;

procedure TvendaForm.editQuantKeyPress(Sender: TObject; var Key: Char);
begin
  // Verifica se a tecla pressionada � um n�mero, v�rgula, ponto ou a tecla de backspace (para apagar)
  if not (Key in ['0'..'9', ',', '.', #8]) then
    Key := #0  // Se n�o for permitido, cancela o caractere
  else
  begin
    // Trata para evitar erro de convers�o
    if (Key = '.') then
      Key := ',';
    // Evita a inser��o de m�ltiplas v�rgulas ou pontos
    if (Key = ',') and (Pos(',', TEdit(Sender).Text) > 0) then
      Key := #0;
  end;
end;

procedure TvendaForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
  begin
    if pesquisaCliForm.ModalResult = mrOk then

  end;

end;

procedure TvendaForm.FormResize(Sender: TObject);
begin
  editCodigo.Width := 69;
  editNome.Width   := (pnlEdit.Width - (69*3) - 110);
  editQuant.Width  := 69;
  editValor.Width  := 69;
  lblCod.Width     := 69;
  lblNome.Width    := (pnlEdit.Width - (69*3) - 110);
  lblQuant.Width   := 69;
  lblValor.Width   := 69;
  if Assigned(FListBox) then
  FListBox.Width   := editNome.Width;
end;

procedure TvendaForm.FormShow(Sender: TObject);
begin
  iniciaForm;
end;

procedure TvendaForm.insereProduto;
begin
  with cdsItens, FieldDefs do
  begin
    Append;
    FieldByName('CODIGO').AsInteger     := StrToInt(editCodigo.Text);
    FieldByName('NOME').AsString        := editNome.Text;
    FieldByName('QUANTIDADE').AsFloat   := StrToFloat(editQuant.Text);
    FieldByName('VLR_UNIT').AsCurrency  := StrToFloat(editValor.Text);
    Post;
  end;
end;

procedure TvendaForm.ListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Valores : TArray<String>;
begin
  if Key = VK_RETURN then
  begin
    if (FListBox.ItemIndex <> - 1) and (FListBox.Count > 0) then
    begin
      Valores         := FListBox.Items[FListBox.ItemIndex].Split([',']);
      editCodigo.Text := Trim(Valores[0]);
      editNome.Text   := Trim(Valores[1]);
      editValor.Text  := Trim(Valores[2]).Replace('.',',',[rfReplaceAll,rfIgnoreCase]);
      editQuant.Text  := '1';
      editQuant.SetFocus;
      editQuant.SelectAll;
      if Assigned(FListBox) then FreeAndNil(FListBox)      
    end;
  end;
end;

procedure TvendaForm.imgClienteClick(Sender: TObject);
begin
  pesquisaCliForm.ShowModal;
  if pesquisaCliForm.ModalResult = mrOk then
  begin
    lblCliente.Caption := Dm.FDQ_Cliente.FieldByName('CODIGO').AsString + '-' + Dm.FDQ_Cliente.FieldByName('NOME').AsString
  end;
end;

procedure TvendaForm.imgDeletarVendaClick(Sender: TObject);
begin
  if FVenda.Venda.Numero = 0 then
  begin
    ShowMessage('Venda n�o finalizada!');
    Exit;
  end;
  if MessageDlg('Deseja excluir a venda?', mtConfirmation,
     [mbYes, mbNo], 0) = mrYes then FVenda.ExcluirVenda;
  iniciaForm;
end;

procedure TvendaForm.imgPesquisaClick(Sender: TObject);
var Query : TFDQuery;
begin
  Dm.FDQ_Venda.Close;
  Dm.FDQ_Venda.Open;
  pesquisaVendaForm.ShowModal;
  if pesquisaVendaForm.ModalResult = mrOk then
  begin
    if Assigned(FVenda) then FreeAndNil(FVenda);
    FVenda                      := TVendaController.Create;
    FVenda.Venda.Numero         := Dm.FDQ_Venda.FieldByName('CODIGO_PEDIDO').AsInteger;
    FVenda.Venda.Cliente.Codigo := Dm.FDQ_Venda.FieldByName('COD_CLI').AsInteger;
    lblCliente.Caption          := Dm.FDQ_Venda.FieldByName('COD_CLI').AsString + '-' + Dm.FDQ_Venda.FieldByName('NOME').AsString;
    if not cdsItens.IsEmpty then    
    cdsItens.EmptyDataSet;
    Query := TFDQuery.Create(nil);
    try
      Query := FVenda.ItensDaVenda;
      if Query.RecordCount > 0 then
      begin
        Query.First;
        while not Query.Eof do
        begin
          with Query do
          begin
            insereProduto(FieldByName('CODIGO').AsInteger,
                          FieldByName('DESCRICAO').AsString,
                          FieldByName('QUANT').AsFloat,
                          FieldByName('VLR_UNIT').AsCurrency);
            carregaTotais;
            Next;
          end;
        end;
      end;
    finally
      Query.Free;
    end;
  end;
end;

procedure TvendaForm.iniciaDataSet;
begin
  with cdsItens, FieldDefs do
  begin
    Clear;
    Add('CODIGO',     ftInteger);
    Add('NOME',       ftString, 100);
    Add('QUANTIDADE', ftFloat);
    Add('VLR_UNIT',   ftCurrency);
    Add('VLR_TOTAL',  ftCurrency);
    if not Active then    
    CreateDataSet;
  end;
end;

procedure TvendaForm.iniciaForm;
begin
  if Assigned(FVenda) then FreeAndNil(FVenda);
  if not cdsItens.IsEmpty then cdsItens.EmptyDataSet;
  FVenda          := TVendaController.Create;
  editCodigo.Text := '';
  editNome.Text   := 'Digite aqui para pesquisar seu produto';
  editQuant.Text  := '';
  editValor.Text  := '';

  lblVlrTotal.Caption := 'R$ 0,00';
  lblCliente.Caption  := 'CONSUMIDOR';
  lblQntItens.Caption := 'QTD: 0';
  lblNumItens.Caption := 'N� ITENS: 0';

  iniciaDataSet;
  editNome.SetFocus;
end;

procedure TvendaForm.insereProduto(Codigo: Integer; Nome: String;
  Quant: Extended; Vlr_Unit: Currency);
begin
  with cdsItens, FieldDefs do
  begin
    Append;
    FieldByName('CODIGO').AsInteger     := Codigo;
    FieldByName('NOME').AsString        := Nome;
    FieldByName('QUANTIDADE').AsFloat   := Quant;
    FieldByName('VLR_UNIT').AsCurrency  := Vlr_Unit;
    Post;
  end;
end;

procedure TvendaForm.pesquisaProduto;
var
  Valores: TArray<string>;
  StringList : TStringList;
  i : Integer;
begin
  StringList := TStringList.Create;
  StringList := DmFun.pesquisaProdutos(editNome.Text);
  if StringList.Count > 0 then
  begin
    criaListBox;
    for i := 0 to StringList.Count - 1 do
    begin
      FListBox.Items.Add(StringList[i]);
    end;
  end;
end;

procedure TvendaForm.pnlCancelaClick(Sender: TObject);
begin
  iniciaForm;
end;

procedure TvendaForm.pnlFinalizaClick(Sender: TObject);
begin
  if lblCliente.Caption = 'CONSUMIDOR' then
  begin
    ShowMessage('Venda sem cliente designado!');
    Exit;
  end;

  if cdsItens.IsEmpty then
  begin
    ShowMessage('Nenhum produto registrado.');
    Exit;
  end;

  cdsItens.First;
  while not cdsItens.Eof do
  begin
    with cdsItens do
    begin
      FVenda.AdicionarProduto(FieldByName('CODIGO').AsInteger,
                              FieldByName('VLR_UNIT').AsCurrency,
                              FieldByName('NOME').AsString,
                              FieldByName('QUANTIDADE').AsExtended);
    end;
    cdsItens.Next;
  end;

  FVenda.Venda.Cliente.Codigo := StrToInt(DmFun.somenteNumeros(lblCliente.Caption));

  if FVenda.Venda.Numero = 0 then
  FVenda.FinalizarVenda
  else
  FVenda.AlterarVenda;

  ShowMessage('Venda Finalizada!');
  iniciaForm;
end;

procedure TvendaForm.pnlFundoMouseEnter(Sender: TObject);
begin
  pnlMenu.Width := 60;
end;

procedure TvendaForm.pnlMenuMouseEnter(Sender: TObject);
begin
  pnlMenu.Width := 177;
end;

procedure TvendaForm.pnlMenuResize(Sender: TObject);
begin
  editCodigo.Width := 69;
  editNome.Width   := (pnlEdit.Width - (69*3) - 150);
  editQuant.Width  := 69;
  editValor.Width  := 69;
  lblCod.Width     := 69;
  lblNome.Width    := (pnlEdit.Width - (69*3) - 150);
  lblQuant.Width   := 69;
  lblValor.Width   := 69;
  if Assigned(FListBox) then
  FListBox.Width   := editNome.Width;
end;

procedure TvendaForm.pnlSairClick(Sender: TObject);
begin
  Close;
end;

procedure TvendaForm.pnlSairMouseEnter(Sender: TObject);
begin
  pnlSair.Color := clMaroon;
end;

procedure TvendaForm.pnlSairMouseLeave(Sender: TObject);
begin
  pnlSair.Color := $00292929;
end;

procedure TvendaForm.SpeedButton1Click(Sender: TObject);
begin
  if cdsItens.State in [dsEdit] then
  cdsItens.Post
  else
  begin
    if (Trim(editCodigo.Text) = '') or (Trim(editNome.Text) = '') then
    begin
      ShowMessage('Nenhum produto foi selecionado!');
      Exit;
    end;

    if (Trim(editQuant.Text) = '') then
    begin
      ShowMessage('Quantidade n�o pode ser vazia!');
      Exit;
    end;

    insereProduto;
  end;
  carregaTotais;
  editCodigo.Text := '';
  editNome.Text   := 'Digite aqui para pesquisar seu produto';
  editQuant.Text  := '';
  editValor.Text  := '';
  editNome.SetFocus;
end;

end.
