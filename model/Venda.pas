unit Venda;

interface

uses
  Produto, Cliente, System.Generics.Collections;

type
  TVenda = class
  private
    FNumero: Integer;
    FData: TDateTime;
    FProdutos: TList<TProduto>;
    FCliente: TCliente;
    FTotal: Currency;
    procedure CalcularTotal;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarProduto(AProduto: TProduto);
    property Numero: Integer read FNumero write FNumero;
    property Data: TDateTime read FData write FData;
    property Total: Currency read FTotal;
    property Produtos: TList<TProduto> read FProdutos write FProdutos;
    property Cliente: TCliente read FCliente write FCliente;
  end;

implementation

constructor TVenda.Create;
begin
  FProdutos := TList<TProduto>.Create;
  FCliente  := TCliente.Create;
end;

destructor TVenda.Destroy;
begin
  FProdutos.Free;
  FCliente.Free;
  inherited;
end;

procedure TVenda.AdicionarProduto(AProduto: TProduto);
begin
  FProdutos.Add(AProduto);
  CalcularTotal;
end;

procedure TVenda.CalcularTotal;
var
  Produto: TProduto;
begin
  FTotal := 0;
  for Produto in FProdutos do
    FTotal := FTotal + (Produto.Preco * Produto.Quantidade);
end;

end.

