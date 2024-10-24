unit formVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

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
    Image1: TImage;
    Label5: TLabel;
    Panel8: TPanel;
    Image3: TImage;
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
    procedure pnlSairClick(Sender: TObject);
    procedure pnlSairMouseEnter(Sender: TObject);
    procedure pnlSairMouseLeave(Sender: TObject);
    procedure pnlMenuMouseEnter(Sender: TObject);
    procedure pnlMenuMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vendaForm: TvendaForm;

implementation

{$R *.dfm}

procedure TvendaForm.pnlMenuMouseEnter(Sender: TObject);
begin
  pnlMenu.Width := 177;
end;

procedure TvendaForm.pnlMenuMouseLeave(Sender: TObject);
begin
  pnlMenu.Width := 60;
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
