unit formPesquisaVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, dmDatabase;

type
  TpesquisaVendaForm = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pesquisaVendaForm: TpesquisaVendaForm;

implementation

{$R *.dfm}

procedure TpesquisaVendaForm.DBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
