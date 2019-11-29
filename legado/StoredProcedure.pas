unit StoredProcedure;

interface

uses
  Classes, SysUtils, DBXpress, DB, SqlExpr, DBClient, Provider, ConfigBD;

type
  PParametro = ^TParametro;
  TParametro = record
    nome: String;
    valor: Variant;
    tipoDado: TFieldType;
    tipoParametro: TParamType;
  end;

type
  TStoredProcedure = class(TComponent)
  private
    FSchemaName: String;
    FPackageName: String;
    FTableSapace: String;
    FQuery: TSQLQuery;
    FClientDataSet: TClientDataSet;
    FDataSetProvider: TDataSetProvider;
    FNome: String;
    FParametros: TList;
  protected
    function getSQL: String; virtual;
    procedure addParametro(nome: String; valor: Variant;
      tipoDado: TFieldType; tipoParametro: TParamType); overload;
  public
    function getSchemaName: String;
    procedure setSchemaName(schemaName: String);
    function getPackageName: String;
    procedure setPackageName(packageName: String);
    function getTableSapace: String;
    procedure setTableSapace(tableSapace: String);
    function getNome: String;
    procedure setNome(nome: String);
    function executar(getMetadata: Boolean = True): String; virtual;
    procedure addParametro(nome: String; valor: Variant); overload;
    class function getStoredProcedure(tipoBanco: TTipoBanco): TStoredProcedure;
    constructor Create(AOwner: TComponent = nil); override;
    destructor Destroy; override;
  end;

implementation

uses ConexaoBD, StoredProcedureFirebird, StoredProcedureOracle,
  StoredProcedurePostgreSQL;

{ TStoredProcedure }

procedure TStoredProcedure.addParametro(nome: String; valor: Variant);
var
  parametro : PParametro;
begin
  new(parametro);
  parametro^.nome := nome;
  parametro^.valor := valor;
  parametro^.tipoDado := ftUnknown;
  parametro^.tipoParametro := ptInput;
  FParametros.Add(parametro);
end;

procedure TStoredProcedure.addParametro(nome: String; valor: Variant;
  tipoDado: TFieldType; tipoParametro: TParamType);
var
  parametro : PParametro;
begin
  new(parametro);
  parametro^.nome := nome;
  parametro^.valor := valor;
  parametro^.tipoDado := tipoDado;
  parametro^.tipoParametro := tipoParametro;
  FParametros.Add(parametro);
end;

constructor TStoredProcedure.Create(AOwner: TComponent = nil);
begin
  FParametros := TList.Create;

  FQuery := TSQLQuery.Create(Self);
  with FQuery do
  begin
    Close;
    SQLConnection := conexao.getConexao;
  end;

  FDataSetProvider := TDataSetProvider.Create(Self);
  with FDataSetProvider do
  begin
    DataSet := FQuery;
    Name := 'Provider';
  end;

  FClientDataSet := TClientDataSet.Create(Self);
  with FClientDataSet do
  begin
    Close;
    ProviderName := FDataSetProvider.Name;
  end;
end;

destructor TStoredProcedure.Destroy;
begin
  if Assigned(FQuery) then
    FQuery.Free;
  if Assigned(FDataSetProvider) then
    FDataSetProvider.Free;
  if Assigned(FClientDataSet) then
    FClientDataSet.Free;
  if Assigned(FParametros) then
  begin
    FParametros.Clear;
    FParametros.Pack;
    FParametros.Free;
  end;
  inherited;
end;

function TStoredProcedure.executar(getMetadata: Boolean): String;
var
  cont: byte;
  parametros: TParams;
  td: TTransactionDesc;
begin
  Result := EmptyStr;

  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(getSQL);

  if getMetadata then
  begin
    FClientDataSet.Close;
    FClientDataSet.FetchParams;
    parametros := FClientDataSet.Params;
  end
  else
    parametros := FQuery.Params;

  for cont := 0 to (FParametros.Count - 1) do
  begin
    parametros.ParamByName(PParametro(FParametros[cont])^.nome).ParamType :=
      PParametro(FParametros[cont])^.tipoParametro;
    parametros.ParamByName(PParametro(FParametros[cont])^.nome).DataType :=
      PParametro(FParametros[cont])^.tipoDado;
    parametros.ParamByName(PParametro(FParametros[cont])^.nome).Value :=
      PParametro(FParametros[cont])^.valor;
  end;

  if getMetadata then
  begin
    FClientDataSet.Open;
    Result := FClientDataSet.XMLData;
  end
  else
  begin
    conexao.startTransaction(td);
    try
      FQuery.ExecSQL;
      FQuery.Close;
      conexao.commitTransaction(td);
    except
      on E:Exception do
      begin
        conexao.rollbackTransaction(td);
        raise;
      end;
    end;
  end;
end;

class function TStoredProcedure.getStoredProcedure(
  tipoBanco: TTipoBanco): TStoredProcedure;
begin
  Result := nil;
  case tipoBanco of
    tbFirebird:
    begin
      Result := TStoredProcedureFirebird.Create;
    end;//tbFirebird:
    tbOracle:
    begin
      Result := TStoredProcedureOracle.Create;
    end;//tbOracle:
    tbPostGreSQL:
    begin
      Result := TStoredProcedurePostgreSQL.Create;
    end;//tbOracle:
  end;//case tipoBanco of
end;

function TStoredProcedure.getNome: String;
begin
  Result := FNome;
end;

function TStoredProcedure.getSQL: String;
var
  cont: byte;
begin
  Result := EmptyStr;
  for cont := 0 to (FParametros.Count - 1) do
  begin
    Result := Result + ':' + PParametro(FParametros[cont])^.nome;
    if (cont <> (FParametros.Count - 1)) then
      Result := Result + ', ';
  end;
  Result := FNome + '(' + Result + ')';
end;

procedure TStoredProcedure.setNome(nome: String);
begin
  FNome := nome;
end;


procedure TStoredProcedure.setSchemaName(schemaName: String);
begin
  FSchemaName := schemaName;
end;

function TStoredProcedure.getPackageName: String;
begin
  Result := FPackageName;
end;

function TStoredProcedure.getTableSapace: String;
begin
  Result := FTableSapace;
end;

procedure TStoredProcedure.setPackageName(packageName: String);
begin
  FPackageName := packageName;
end;

function TStoredProcedure.getSchemaName: String;
begin
  Result := FSchemaName;
end;

procedure TStoredProcedure.setTableSapace(tableSapace: String);
begin
  FTableSapace := tableSapace;
end;


end.
