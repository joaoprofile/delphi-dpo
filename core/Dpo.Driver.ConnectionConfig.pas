unit Dpo.Driver.ConnectionConfig;

interface

uses
  Classes, SysUtils,

  jc.Libs.Interfaces,
  Dpo.Driver.Interfaces;

type
  TConnectionConfig = Class(TInterfacedObject, IConnectionConfig)
  Private
    jcIniFile: IJcIniFile;

    FDriverName: TDriverName;
    FConnectionName: String;
  Public
    constructor Create;
    destructor Destroy; override;
    class function New: IConnectionConfig;

    function getParamsConnection: String;
    function getDriverName: TDriverName;
    function getConnectionName: String;
  End;

implementation

uses
  jc.IniFile;

{ TDriverConfig }

class function TConnectionConfig.New(): IConnectionConfig;
begin
   result := self.create;
end;

constructor TConnectionConfig.Create;
var
  sDriverName: String;
  lFileName: string;
begin
  lFileName := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'dpoconn.config';

  if not SysUtils.FileExists(lFileName) then
    Raise Exception.Create('Arquivo de configurações da Conexão de Banco de dados não encontrado');

  jcIniFile := TJcIniFile.Get(lFileName);
  sDriverName := jcIniFile.GetString('Database', 'DriverName', EmptyStr);

  if sDriverName = emptyStr then
    Raise Exception.Create('DriverName não definido nas configurações de Banco de dados');

  if sDriverName = 'FB' then
    FDriverName := Firebird;

  FConnectionName := jcIniFile.GetString('Database', 'ConnectionName', EmptyStr);
end;

destructor TConnectionConfig.Destroy;
begin

  inherited;
end;

function TConnectionConfig.getParamsConnection: String;
var
  lParams : TStrings;
begin
  lParams := TStringList.Create;
  try
    jcIniFile.GetSectionValues(FConnectionName, lParams);
    if lParams.Text = emptyStr then
      Raise Exception.Create('Parametros nao definidos nas configuracoes da conexao de Banco de Dados '+FConnectionName);

    Result := lParams.Text;
  finally
    lParams.Free;
  end;
end;

function TConnectionConfig.getDriverName: TDriverName;
begin
  Result := FDriverName;
end;

function TConnectionConfig.getConnectionName: String;
begin
  Result := FConnectionName;
end;

end.

