unit Produto.Service;

interface

uses
  IProduto.Service,
  Produto.Model,
  IProduto.Repository,
  System.SysUtils,
  System.Generics.Collections, Validador.Contracts, Produto.Validation,
  DMConexao.infra, Produto.Repository;
type
 TProdutoService = class(TInterfacedObject, IProdutoService)

  private
    FRepository : IProdutoRepository;


  public
   constructor Create(Adm : Tdm);
   procedure Salvar(AProduto: TProduto);
   procedure Excluir(AId : Integer);
   function ListarProdutos : TObjectList<TProduto>;
   function BuscarPorId(AId: Integer) : TProduto;
   function PesquisarProdutos(APesquisa: String): TObjectList<TProduto>;

 end;

implementation

{ TProdutoService }

constructor TProdutoService.Create(Adm : Tdm);
begin
FRepository := TProdutoRepository.Create(Adm)

end;

procedure TProdutoService.Salvar(AProduto: TProduto);
var
  Validador: IValidador<TProduto>;
begin
  Validador := TProdutoValidador.Create;
try
     Validador.Validar(AProduto);

 if AProduto.Id = 0 then
   FRepository.Inserir(AProduto)
 else
   FRepository.Atualizar(AProduto);

except
   on E: Exception do
     raise Exception.CreateFmt('Erro ao salvar Produto: %s', [E.Message]);
end;
end;

procedure TProdutoService.Excluir(AId: Integer);
begin
if AId <= 0 then
  raise Exception.Create('ID inválido');

FRepository.Excluir(AId);
end;

function TProdutoService.ListarProdutos: TObjectList<TProduto>;
begin
 Result := FRepository.Listar;
end;

function TProdutoService.PesquisarProdutos(
  APesquisa: String): TObjectList<TProduto>;
begin
  if APesquisa.Trim.IsEmpty then
    raise Exception.Create('Digite algo para pesquisar');

  Result := FRepository.PesquisarProdutos(APesquisa);
end;

function TProdutoService.BuscarPorId(AId: Integer): TProduto;
begin
Result := FRepository.BuscarPorId(AId);
end;

end.
