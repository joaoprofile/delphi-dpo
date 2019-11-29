unit ConexaoBD;

interface

uses Classes, DBXpress, DB, SqlExpr, SysUtils,
     ConfigBD;

type TConexaoBD = class

private
  FTipoBanco: TTipoBanco;
protected
  FConexao: TSQLConnection;
public
  procedure conectar(config: TConfigBD);
  procedure setTipoBanco(tipoBanco: TTipoBanco);
  function getConexao(): TSQLConnection;
  function getTipoBanco(): TTipoBanco;
  procedure startTransaction(var td: TTransactionDesc);
  procedure commitTransaction(td: TTransactionDesc);
  procedure rollbackTransaction(td: TTransactionDesc);
end;

var
  conexao: TConexaoBD;

implementation

{ TUntBD }


procedure TConexaoBD.commitTransaction(td: TTransactionDesc);
begin
  if FConexao.InTransaction then
    FConexao.Commit(td);
end;

procedure TConexaoBD.conectar(config: TConfigBD);
begin
  FConexao := TSQLConnection.Create(nil);
  with FConexao do
  begin
    Connected := false;
    LoginPrompt := False;
    ConnectionName := config.getConnectionName;
    VendorLib := config.getVendorLib;
    LibraryName := config.getLibraryName;
    DriverName := config.getDriverName;
    GetDriverFunc := config.getDriverFunc;
    Params.Text := config.getParamConexao;
    Connected := True;
  end;
end;

function TConexaoBD.getConexao: TSQLConnection;
begin
  Result := FConexao;
end;

function TConexaoBD.getTipoBanco: TTipoBanco;
begin
  Result := FTipoBanco;
end;

procedure TConexaoBD.rollbackTransaction(td: TTransactionDesc);
begin
  if FConexao.InTransaction then
    FConexao.Rollback(td);
end;

procedure TConexaoBD.setTipoBanco(tipoBanco: TTipoBanco);
begin
  FTipoBanco := tipoBanco;
end;

procedure TConexaoBD.startTransaction(var td: TTransactionDesc);
begin
  with td do
  begin
    TransactionID := 1;
    GlobalID := 1;
    IsolationLevel :=  xilREADCOMMITTED;
  end;
  FConexao.StartTransaction(td);
end;

end.

