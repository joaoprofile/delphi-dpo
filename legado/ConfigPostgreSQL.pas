unit ConfigPostgreSQL;

interface

uses
  ConfigBD;

type TConfigPostgreSQL = class(TConfigBD)

public
  function getParamConexao: String; override;
  function getDriverName: String; override;
  function getLibraryName: String; override;
  function getVendorLib: String; override;
  function getDriverFunc: String; override;
  function getConnectionName: String; override;
end;

implementation


{ TConfigPostgreSQL }

function TConfigPostgreSQL.getConnectionName: String;
begin
  Result := 'PGEConnection';
end;

function TConfigPostgreSQL.getDriverFunc: String;
begin
  Result := 'getSQLDriverPOSTGRESQL';
end;

function TConfigPostgreSQL.getDriverName: String;
begin
  Result := 'PostgreSQL';
end;

function TConfigPostgreSQL.getLibraryName: String;
begin
  Result := 'dbexppge.dll';
end;

function TConfigPostgreSQL.getParamConexao: String;
begin
  Result := 'BlobSize=32' + #13#10 +
    'HostName=192.168.10.25' + #13#10 +
    'Database=dds' + #13#10 +
    'DriverName=PostgreSQL' + #13#10 +
    'Password=' + #13#10 +
    'User_Name=postgres';
end;

function TConfigPostgreSQL.getVendorLib: String;
begin
  Result := 'LIBPQ.DLL';
end;

end.


