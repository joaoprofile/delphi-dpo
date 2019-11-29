unit ConfigFirebird;

interface

uses
  ConfigBD;

type TConfigFirebird = class(TConfigBD)

public
  function getParamConexao: String; override;
  function getDriverName: String; override;
  function getLibraryName: String; override;
  function getVendorLib: String; override;
  function getDriverFunc: String; override;
  function getConnectionName: String; override;
end;

implementation


{ TConfigFirebird }

function TConfigFirebird.getConnectionName: String;
begin
  Result := 'IBConnection';
end;

function TConfigFirebird.getDriverFunc: String;
begin
  Result := 'getSQLDriverINTERBASE';
end;

function TConfigFirebird.getDriverName: String;
begin
  Result := 'Interbase';
end;

function TConfigFirebird.getLibraryName: String;
begin
  Result := 'dbexpint.dll';
end;

function TConfigFirebird.getParamConexao: String;
begin
  Result := 'DriverName=Interbase' + #13#10 +
    'Database=C:\dados\jcs\dados.jcs' + #13#10 +
    'User_Name=issdigital' + #13#10 +
    'Password=dsfimaressonda' + #13#10 +
    'SQLDialect=1' + #13#10 +
    'LocaleCode=0000' + #13#10 +
    'BlobSize=-1' + #13#10 +
    'CommitRetain=True' + #13#10 +
    'WaitOnLocks=True' + #13#10 +
    'Interbase TransIsolation=ReadCommited' + #13#10 +
    'Trim Char=Falsepublic';
end;

function TConfigFirebird.getVendorLib: String;
begin
  Result := 'gds32.dll';
end;

end.


