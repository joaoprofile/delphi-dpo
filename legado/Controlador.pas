unit Controlador;

interface

uses
  Consulta, Inclusao, Exclusao, Alteracao, ConfigBD;
type
  TControlador = class
  private
    FConsulta: TConsulta;
    FExclusao: TExclusao;
    FInclusao: TInclusao;
    FAlteracao: TAlteracao;
  public
    function getAlteracao: TAlteracao;
    function getConsulta: TConsulta;
    function getExclusao: TExclusao;
    function getInclusao: TInclusao;
    constructor Create(tipoBanco: TTipoBanco);
    destructor Destroy; override;
  end;

implementation

{ TControlador }

constructor TControlador.Create(tipoBanco: TTipoBanco);
begin
  FAlteracao := TAlteracao.getAlteracao(tipoBanco);
  FConsulta  := TConsulta.getConsulta(tipoBanco);
  FExclusao  := TExclusao.getExclusao(tipoBanco);
  FInclusao  := TInclusao.getInclusao(tipoBanco);
end;

destructor TControlador.Destroy;
begin
  inherited;
  if Assigned(FAlteracao) then
    FAlteracao.Free;
  if Assigned(FConsulta) then
    FConsulta.Free;
  if Assigned(FExclusao) then
    FExclusao.Free;
  if Assigned(FInclusao) then
    FInclusao.Free;
end;

function TControlador.getAlteracao: TAlteracao;
begin
  Result := FAlteracao;
end;

function TControlador.getConsulta: TConsulta;
begin
  Result := FConsulta;
end;

function TControlador.getExclusao: TExclusao;
begin
  Result := FExclusao;
end;

function TControlador.getInclusao: TInclusao;
begin
  Result := FInclusao;
end;

end.
