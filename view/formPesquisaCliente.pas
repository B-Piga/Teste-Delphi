unit formPesquisaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TpesquisaCliForm = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    editNome: TEdit;
    Label1: TLabel;
    procedure editNomeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pesquisaCliForm: TpesquisaCliForm;

implementation

{$R *.dfm}

uses dmDatabase;

procedure TpesquisaCliForm.DBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TpesquisaCliForm.editNomeChange(Sender: TObject);
begin
  if Trim(editNome.Text) = '' then Exit;
  with Dm.FDQ_Cliente, SQL do
  begin
    Close;
    Clear;
    Add('select codigo, nome from tbClientes where nome LIKE :nome');
    ParamByName('NOME').AsString := editNome.Text + '%';
    Open;
  end;
end;

procedure TpesquisaCliForm.FormShow(Sender: TObject);
begin
  editNome.SetFocus;
end;

end.
