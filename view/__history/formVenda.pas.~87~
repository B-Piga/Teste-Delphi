unit formVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

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
    Label3: TLabel;
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
    Image4: TImage;
    lblTotal: TLabel;
    lblVlrTotal: TLabel;
    DBGrid1: TDBGrid;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    Label7: TLabel;
    Label8: TLabel;
    procedure pnlSairClick(Sender: TObject);
    procedure pnlSairMouseEnter(Sender: TObject);
    procedure pnlSairMouseLeave(Sender: TObject);
    procedure pnlMenuMouseEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlFundoMouseEnter(Sender: TObject);
    procedure pnlMenuResize(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure editQuantKeyPress(Sender: TObject; var Key: Char);
    procedure pnlCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure iniciaDataSet;
    procedure iniciaForm;
  public
    { Public declarations }
  end;

var
  vendaForm: TvendaForm;

implementation

{$R *.dfm}

procedure TvendaForm.editQuantKeyPress(Sender: TObject; var Key: Char);
begin
  // Verifica se a tecla pressionada é um número, vírgula, ponto ou a tecla de backspace (para apagar)
  if not (Key in ['0'..'9', ',', '.', #8]) then
    Key := #0  // Se não for permitido, cancela o caractere
  else
  begin
    // Evita a inserção de múltiplas vírgulas ou pontos
    if (Key = ',') and (Pos(',', TEdit(Sender).Text) > 0) then
      Key := #0;

    if (Key = '.') and (Pos('.', TEdit(Sender).Text) > 0) then
      Key := #0;
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
end;

procedure TvendaForm.FormShow(Sender: TObject);
begin
  iniciaForm;
end;

procedure TvendaForm.Image4Click(Sender: TObject);
begin
  with cdsItens, FieldDefs do
  begin
    Append;
    FieldByName('CODIGO').AsInteger     := StrToInt(editCodigo.Text);
    FieldByName('NOME').AsString        := editNome.Text;
    FieldByName('QUANTIDADE').AsFloat   := StrToFloat(editQuant.Text);
    FieldByName('VLR_UNIT').AsCurrency  := StrToFloat(editValor.Text);
    FieldByName('VLR_TOTAL').AsCurrency := StrToFloat(editValor.Text) * StrToFloat(editQuant.Text);
    Post;
  end;
end;

procedure TvendaForm.iniciaDataSet;
begin
  with cdsItens, FieldDefs do
  begin
    Clear;
    Add('CODIGO', ftInteger);
    Add('NOME', ftString, 100);
    Add('QUANTIDADE', ftFloat);
    Add('VLR_UNIT', ftCurrency);
    Add('VLR_TOTAL', ftCurrency);
    if not Active then    
    CreateDataSet;
  end;
end;

procedure TvendaForm.iniciaForm;
begin
  editCodigo.Text := '';
  editNome.Text   := 'Pressione ENTER para pesquisar';
  editQuant.Text  := '';
  editValor.Text  := '';
  lblVlrTotal.Caption := 'R$ 0,00';
  lblCliente.Caption  := 'CONSUMIDOR';
end;

procedure TvendaForm.pnlCancelaClick(Sender: TObject);
begin
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
  editNome.Width   := (pnlEdit.Width - (69*3) - 110);
  editQuant.Width  := 69;
  editValor.Width  := 69;
  lblCod.Width     := 69;
  lblNome.Width    := (pnlEdit.Width - (69*3) - 110);
  lblQuant.Width   := 69;
  lblValor.Width   := 69;
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

end.
