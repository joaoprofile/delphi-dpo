unit Operacao;

interface

const
  ident: String = '  ';

type
  TOperacao = class
  private
    FCampos: String;
    FTabela: String;
    FCondicao: String;
    FValores: String;
   public
    function getCampos: String;
    function getTabela: String;
    function getCondicao: String;
    function getValores: String;
    procedure setCampos(campos: String);
    procedure setTabela(tabela: String);
    procedure setCondicao(condicao: String);
    procedure setValores(valores: String);
  protected
    function getSQL: string; virtual; abstract;
  end;

implementation

{ TOperacao }

function TOperacao.getValores: String;
begin
  Result := FValores;
end;

function TOperacao.getTabela: String;
begin
  Result := FTabela;
end;

function TOperacao.getCampos: String;
begin
  Result := FCampos;
end;

function TOperacao.getCondicao: String;
begin
  Result := FCondicao;
end;

procedure TOperacao.setValores(valores: String);
begin
  FValores := valores;
end;

procedure TOperacao.setTabela(tabela: String);
begin
  FTabela := tabela;
end;

procedure TOperacao.setCampos(campos: String);
begin
  FCampos := campos;
end;

procedure TOperacao.setCondicao(condicao: String);
begin
  FCondicao := condicao;
end;

end.



