unit dmFuncoes;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Generics.Collections, System.Classes,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI, FireDAC.DApt, Dialogs;

type
  TDmFun = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  function pesquisaProdutos(AString: String): TStringList;
  function somenteNumeros(AString : String): String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmFun: TDmFun;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmDatabase;

{$R *.dfm}

{ TDmFun }

function TDmFun.pesquisaProdutos(AString: String): TStringList;
var
  FString: TStringList;
  SString: String;
  FDQuery: TFDQuery;
begin
  FString := TStringList.Create;
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := Dm.FDC_MySQL;
    FDQuery.SQL.Add('select * from tbprodutos');
    FDQuery.SQL.Add('where descricao LIKE :desc');
    FDQuery.SQL.Add('order by descricao');
    FDQuery.ParamByName('desc').AsString := AString + '%';
    FDQuery.Open;
    if not FDQuery.IsEmpty then
    begin
      FDQuery.First;
      while not FDQuery.Eof do
      begin
        SString := '';
        SString := FDQuery.FieldByName('CODIGO').AsString + ',' +
                   FDQuery.FieldByName('DESCRICAO').AsString + ',' +
                   FDQuery.FieldByName('PRECO').AsString.Replace(',','.',[rfReplaceAll,rfIgnoreCase]);
        FString.Add(SString);
        FDQuery.Next;
      end;
    end;
    Result := FString;
  finally
    FDQuery.Free;  // Libera o FDQuery
  end;
end;

function TDmFun.somenteNumeros(AString: String): String;
var vText : PChar;
begin
  vText := PChar(AString);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

end.
