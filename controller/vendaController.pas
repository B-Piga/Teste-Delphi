unit VendaController;

interface

uses
  Venda, Produto, Cliente, System.SysUtils;

type
  TVendaController = class
  private
    FVenda: TVenda;
  public
    constructor Create;
    destructor Destroy; override;
    procedure IniciarVenda;
    procedure AdicionarProduto(CodigoProduto: Integer;
                               Preco: Currency;
                               Descricao: String;
                               Quantidade: Extended);
    procedure FinalizarVenda;
    property Venda: TVenda read FVenda;
  end;

implementation

constructor TVendaController.Create;
begin
  FVenda := TVenda.Create;
end;

destructor TVendaController.Destroy;
begin
  FVenda.Free;
  inherited;
end;

procedure TVendaController.IniciarVenda;
begin
  FVenda.Numero := Random(1000);  // Exemplo simples para gerar n�mero de venda
  FVenda.Data := Now;
end;

procedure TVendaController.AdicionarProduto(CodigoProduto: Integer; Preco: Currency; Descricao: string; Quantidade : Extended);
var
  Produto: TProduto;
begin
  Produto := TProduto.Create;
  Produto.Codigo := CodigoProduto;
  Produto.Descricao := Descricao;
  Produto.Preco := Preco;
  Produto.Quantidade := Quantidade;
  FVenda.AdicionarProduto(Produto);
end;

procedure TVendaController.FinalizarVenda;
begin
  // Salvar venda no banco de dados ou executar outra l�gica de finaliza��o
  Writeln(Format('Venda %d finalizada com total de %.2f', [FVenda.Numero, FVenda.Total]));
end;

end.

