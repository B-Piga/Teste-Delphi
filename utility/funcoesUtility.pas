unit funcoesUtility;

interface

uses System.SysUtils, FireDAC.Comp.Client, Generics.Collections, System.Classes;

type
  Funcoes = Class
  function pesquisaProdutos(AString: String): TStringList;
  End;

implementation

uses dmDatabase;

function Funcoes.pesquisaProdutos(AString: String): TStringList;
var FString : TStringList;
    SString : String;
begin
  FString.Create;
  with TFDQuery.Create(nil), SQL do
  begin
    Connection := Dm.FDC_MySQL;
    Add('select * from tbprodutos');
    Add('where descricao = :desc');
    ParamByName('desc').AsString := '%'+AString;
    Open;
    if not IsEmpty then
    begin
      First;
      while not Eof do
      begin
        SString := '';
        SString := FieldByName('CODIGO').AsString + ',' + FieldByName('DESCRICAO').AsString + ',' +
                   FieldByName('PRECO').AsString;
        FString.Add(SString);
        Next;
      end;
      Result := FString;
    end;
  end;
end;

end.
