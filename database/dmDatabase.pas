unit dmDatabase;

interface

uses
  System.SysUtils, System.IniFiles, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, Vcl.Dialogs;

type
  TDm = class(TDataModule)
    FDC_MySQL: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDT_MySQL: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDm.DataModuleCreate(Sender: TObject);
var
  Ini: TIniFile;
  Host, Username, Password, DBName: string;
  Port: Integer;
begin
  // L� o arquivo .ini
  Ini := TIniFile.Create('config.ini');
  try
    Host     := Ini.ReadString('database', 'host', 'localhost');
    Username := Ini.ReadString('database', 'username', 'root');
    Password := Ini.ReadString('database', 'password', '');
    DBName   := Ini.ReadString('database', 'dbname', '');
    Port     := Ini.ReadInteger('database', 'port', 3306);
  finally
    Ini.Free;
  end;

  // Atribuindo aos par�metros
  try
    with FDC_MySQL do
    begin
      DriverName := 'MySQL';

      Params.Values['Server']       := Host;
      Params.Values['Port']         := IntToStr(Port);
      Params.Values['Database']     := DBName;
      Params.Values['User_Name']    := Username;
      Params.Values['Password']     := Password;
      Params.Values['CharacterSet'] := 'utf8mb4';

      // Tentando conectar
      Connected := True;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao conectar: ' + E.Message);
  end;
end;

end.