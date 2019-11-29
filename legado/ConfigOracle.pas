unit ConfigOracle;

interface

uses
  ConfigBD;

type TConfigOracle = class(TConfigBD)

public
  function getParamConexao: String; override;
  function getDriverName: String; override;
  function getLibraryName: String; override;
  function getVendorLib: String; override;
  function getDriverFunc: String; override;
  function getConnectionName: String; override;
end;

implementation


{ TConfigOracle }

function TConfigOracle.getConnectionName: String;
begin
  Result := 'OracleConnection';
end;

function TConfigOracle.getDriverFunc: String;
begin
  Result := 'getSQLDriverORACLE';
end;

function TConfigOracle.getDriverName: String;
begin
  Result := 'Oracle';
end;

function TConfigOracle.getLibraryName: String;
begin
  Result := 'dbexpora.dll';
end;

function TConfigOracle.getParamConexao: String;
begin
  Result :=  'DriverName=Oracle' + #13#10 +
    'DataBase=iss' + #13#10 +
    'User_Name=bhz_saf' + #13#10 +
    'Password=bhz' + #13#10 +
    'RowsetSize=20' + #13#10 +
    'BlobSize=-1' + #13#10 +
    'ErrorResourceFile=' + #13#10 +
    'LocaleCode=0000' + #13#10 +
    'Oracle TransIsolation=ReadCommited' + #13#10 +
    'OS Authentication=False' + #13#10 +
    'Multiple Transaction=True' + #13#10 +
    'Trim Char=Fals' + #13#10;
end;

function TConfigOracle.getVendorLib: String;
begin
  Result := 'oci.dll';
end;

end.


