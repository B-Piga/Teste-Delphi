unit Cliente;

interface

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: string;
    FCidade: String;
    FUF: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
  end;

implementation

end.

