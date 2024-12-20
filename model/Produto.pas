unit Produto;

interface

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: string;
    FPreco: Currency;
    FQuantidade: Extended;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property Preco: Currency read FPreco write FPreco;
    property Quantidade: Extended read FQuantidade write FQuantidade;
  end;

implementation

end.
