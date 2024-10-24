unit VendaController;

interface

uses
  Venda, Produto, Cliente, System.SysUtils, FireDAC.Comp.Client;

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

uses dmDatabase;

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
  FVenda.Data := Now;
end;

procedure TVendaController.AdicionarProduto(CodigoProduto: Integer; Preco: Currency; Descricao: string; Quantidade : Extended);
var
  Produto: TProduto;
begin
  Produto            := TProduto.Create;
  Produto.Codigo     := CodigoProduto;
  Produto.Descricao  := Descricao;
  Produto.Preco      := Preco;
  Produto.Quantidade := Quantidade;
  FVenda.AdicionarProduto(Produto);
end;

procedure TVendaController.FinalizarVenda;
var Query : TFDQuery;
    Produto : TProduto;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dm.FDC_MySQL;

    Dm.FDC_MySQL.StartTransaction;
    try
      with Query, SQL do
      begin
        Add('INSERT INTO tbPedido (x1, x2, x3)');
        Add('VALUES (:x1, :x2, :x3)');
        ParamByName('x1').Value := 0;
        ParamByName('x2').Value := 0;
        ParamByName('x3').Value := 0;
        ExecSQL;
        FVenda.Numero := Connection.GetLastAutoGenValue('CODIGO_PEDIDO');

        // *inser��o dos produtos*
        Close;
        Clear;
        for Produto in Venda.Produtos do
        begin
          Add('INSERT INTO tbItensPedido (CODIGO_PEDIDO, COD_PROD, QUANT, VLR_UNIT, VLR_TOTAL)');
          Add('VALUES (:CODIGO_PEDIDO, :COD_PROD, :QUANT, :VLR_UNIT, :VLR_TOTAL)');
          ParamByName('CODIGO_PEDIDO').Value := FVenda.Numero;
          ParamByName('COD_PROD').Value      := Produto.Codigo;
          ParamByName('QUANT').Value         := Produto.Quantidade;
          ParamByName('VLR_UNIT').Value      := Produto.Preco;
          ParamByName('VLR_TOTAL').Value     := (Produto.Quantidade * Produto.Preco);
          ExecSQL;
        end;
        Dm.FDC_MySQL.Commit;
      end;
    except
      on E: Exception do
      begin
        Dm.FDC_MySQL.Rollback;
        raise Exception.Create('Erro ao finalizar a venda: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
  end;
end;

end.

