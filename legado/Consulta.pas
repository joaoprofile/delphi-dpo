unit Consulta;

interface

uses Classes, SysUtils, ConfigBD, Operacao;

type
  TTipoJoin = (tjInner, tjOuter, tjFull);

type
  TJoin =  record
    tabela: String;
    tipoJoin: TTipoJoin;
    condicao: String;
  end;

type
  TJoins = array of TJoin;

type
  TConsulta = class(TOperacao)
  private
    FJoins: TJoins;
    FGroupBy: String;
    FOrderBy: String;
    FQtdRegistros: Integer;
    FSalto: Integer;
  public
    function getJoin(indice: Integer): TJoin;
    function getGroupBy: String;
    function getOrderBy: String;
    function getQtdRegistros: Integer;
    function getSalto: Integer;
    function getSQL: string; override;
    procedure addJoin(tabela: String; tipoJoin: TTipoJoin; condicao: string);
    procedure setGroupBy(groupBy: String);
    procedure setOrderBy(orderBy: String);
    procedure setQtdRegistros(qtdRegistros: Integer);
    procedure setSalto(salto: Integer);
    class function getConsulta(tipoBanco: TTipoBanco): TConsulta;
 end;

implementation

uses ConsultaFirebird, ConsultaOracle, ConsultaPostgreSQL;

{ TConsulta }

procedure TConsulta.setQtdRegistros(qtdRegistros: Integer);
begin
  FQtdRegistros := qtdRegistros;
end;



procedure TConsulta.setOrderBy(orderBy: String);
begin
  FOrderBy := orderBy;
end;

procedure TConsulta.setSalto(salto: Integer);
begin
  FSalto := salto;
end;



function TConsulta.getGroupBy: String;
begin
  Result := FGroupBy;
end;


function TConsulta.getQtdRegistros: Integer;
begin
   Result := FQtdRegistros;
end;


procedure TConsulta.setGroupBy(groupBy: String);
begin
  FGroupBy := groupBy;
end;

function TConsulta.getOrderBy: String;
begin
   Result := FOrderBy;
end;

function TConsulta.getSalto: Integer;
begin
  Result := FSalto;
end;

procedure TConsulta.addJoin(tabela: string; tipoJoin: TTipoJoin;
  condicao: string);
begin
  SetLength(FJoins, Succ(Length(FJoins)));
  FJoins[High(FJoins)].tabela := tabela;
  FJoins[High(FJoins)].tipoJoin := tipoJoin;
  FJoins[High(FJoins)].condicao := condicao;
end;

function TConsulta.getJoin(indice: Integer): TJoin;
begin
   Result := FJoins[indice];
end;

function TConsulta.getSQL: string;
var
  SQL: TStringList;
  cont: Integer;
begin
  SQL := TStringList.Create;
  try
    with SQL do
    begin
      Add('select');
      Add(ident + getCampos);
      Add('from');
      Add(ident + getTabela);
      for cont := Low(FJoins) to High(FJoins) do
      begin
        with FJoins[cont] do
        begin
          case tipoJoin of
            tjInner:
              Add('inner join');
            tjOuter:
              Add('outer join');
            tjFull:
              Add('full join');
          end;
          Add(ident + tabela);
          Add('on');
          Add(ident + '(' + condicao + ')');
        end;
      end;
      if Trim(getCondicao) <> EmptyStr then
      begin
        Add('where');
        Add(ident + getCondicao);
      end;
      if Trim(FGroupBy) <> EmptyStr then
      begin
        Add('group by ');
        Add(ident +  FGroupBy);
      end;
      if Trim(FOrderBy) <> EmptyStr then
      begin
        Add('order by ');
        Add(ident +  FOrderBy);
      end;
    end;
    Result := SQL.Text;
  finally
    SQL.Free;
  end;
end;

class function TConsulta.getConsulta(tipoBanco: TTipoBanco): TConsulta;
begin
  Result := nil;
  case tipoBanco of
    tbFirebird:
    begin
      Result := TConsultaFirebird.Create;
    end;//tbFirebird:
    tbOracle:
    begin
      Result := TConsultaOracle.Create;
    end;//tbOracle:
    tbPostGreSQL:
    begin
      Result := TConsultaPostgreSQL.Create;
    end;//tbOracle:
  end;//case tipoBanco of
end;

end.
