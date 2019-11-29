unit ConfigBD;

interface

uses
  Classes;

type
  TDriverSupport = (drOracle, drSQLServer, drFirebird, drMySQL, drPostGreSQL);

type
  IConfigDB = interface
  ['{C9FB3558-BB8E-455D-8CD4-E2304BDFDA36}']
    function getParamConexao: String;
    function getDriverName: String;
    function getLibraryName: String;
    function getVendorLib: String;
    function getDriverFunc: String;
    function getConnectionName: String;
  end;

  end;
  TConfigBD = class(TInterfacedObject, IConfigDB)
  public
    function getParamConexao: String; abstract; virtual;
    function getDriverName: String;
    function getLibraryName: String;
    function getVendorLib: String;
    function getDriverFunc: String;
    function getConnectionName: String;
    class function getConfigBD(tipoBanco: TTipoBanco):TConfigBD;
  end;

implementation

uses ConfigFirebird, ConfigOracle, ConfigPostgreSQL;

{ TConfigBD }

class function TConfigBD.getConfigBD(tipoBanco: TTipoBanco): TConfigBD;
begin
  Result := nil;
  case tipoBanco of
    tbFirebird:
    begin
      Result := TConfigFirebird.Create;
    end;//tbFirebird:
    tbOracle:
    begin
      Result := TConfigOracle.Create;
    end;//tbOracle:
    tbPostGreSQL:
    begin
      Result := TConfigPostgreSQL.Create;
    end;//tbOracle:
  end;//case tipoBanco of
end;

end.

