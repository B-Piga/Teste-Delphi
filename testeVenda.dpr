program testeVenda;

uses
  Vcl.Forms,
  formVenda in 'view\formVenda.pas' {vendaForm},
  Produto in 'model\Produto.pas',
  Cliente in 'model\Cliente.pas',
  Venda in 'model\Venda.pas',
  vendaController in 'controller\vendaController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TvendaForm, vendaForm);
  Application.Run;
end.
