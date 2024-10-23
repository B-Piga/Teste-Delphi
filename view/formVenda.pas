unit formVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TvendaForm = class(TForm)
    pnlToolBar: TPanel;
    pnlPrincipal: TPanel;
    pnlSair: TPanel;
    pnlFooter: TPanel;
    procedure pnlSairClick(Sender: TObject);
    procedure pnlSairMouseEnter(Sender: TObject);
    procedure pnlSairMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vendaForm: TvendaForm;

implementation

{$R *.dfm}

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
