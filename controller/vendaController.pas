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
    procedure AlterarVenda;
    procedure ExcluirVenda;
    function ItensDaVenda: TFDQuery;
    property Venda: TVenda read FVenda;
  end;

implementation

uses dmDatabase;

procedure TVendaController.AlterarVenda;
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
        Add('UPDATE tbPedidos SET COD_CLI = :COD_CLI, VLR_TOTAL = :VLR_TOTAL');
        Add('WHERE CODIGO_PEDIDO = :COD');
        ParamByName('COD').Value := FVenda.Numero;
        ParamByName('COD_CLI').Value := FVenda.Cliente.Codigo;
        ParamByName('VLR_TOTAL').Value := FVenda.Total;
        ExecSQL;

        // *Reinsere os produtos*
        Close;
        Clear;
        Add('DELETE FROM tbItensPedidos where CODIGO_PEDIDO = :COD');
        ParamByName('COD').Value := FVenda.Numero;
        ExecSQL;

        for Produto in Venda.Produtos do
        begin
          Close;
          Clear;
          Add('INSERT INTO tbItensPedidos (CODIGO_PEDIDO, COD_PRODUTO, QUANT, VLR_UNIT, VLR_TOTAL)');
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

constructor TVendaController.Create;
begin
  FVenda := TVenda.Create;
end;

destructor TVendaController.Destroy;
begin
  FVenda.Free;
  inherited;
end;

procedure TVendaController.ExcluirVenda;
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
        // Deleta os produtos
        Close;
        Clear;
        Add('DELETE FROM tbItensPedidos where CODIGO_PEDIDO = :COD');
        ParamByName('COD').Value := FVenda.Numero;
        ExecSQL;

        Close;
        Clear;
        Add('DELETE FROM tbPedidos WHERE CODIGO_PEDIDO = :COD');
        ParamByName('COD').Value := FVenda.Numero;
        ExecSQL;
        Dm.FDC_MySQL.Commit;
      end;
    except
      on E: Exception do
      begin
        Dm.FDC_MySQL.Rollback;
        raise Exception.Create('Erro ao excluir a venda: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TVendaController.IniciarVenda;
begin
  FVenda.Data := Now;
end;

function TVendaController.ItensDaVenda: TFDQuery;
var Query : TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Dm.FDC_MySQL;
    with Query, SQL do
    begin
      Add('select a.codigo, a.descricao, b.quant, b.vlr_unit from tbItensPedidos b');
      Add('left outer join tbProdutos a on a.codigo = b.cod_produto');
      Add('where b.codigo_pedido = :cod');
      ParamByName('cod').AsInteger := FVenda.Numero;
      Open;
    end;
  finally
    Result := Query;
  end;
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
        Close;
        Clear;
        Add('INSERT INTO tbPedidos (COD_CLI, VLR_TOTAL)');
        Add('VALUES (:COD_CLI, :VLR_TOTAL)');
        ParamByName('COD_CLI').Value := FVenda.Cliente.Codigo;
        ParamByName('VLR_TOTAL').Value := FVenda.Total;
        ExecSQL;
        FVenda.Numero := Connection.GetLastAutoGenValue('CODIGO_PEDIDO');

        // *inser��o dos produtos*
        for Produto in Venda.Produtos do
        begin
          Close;
          Clear;
          Add('INSERT INTO tbItensPedidos (CODIGO_PEDIDO, COD_PRODUTO, QUANT, VLR_UNIT, VLR_TOTAL)');
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

