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
    procedure pnlSairClick(Sender: TObject);
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

end.
