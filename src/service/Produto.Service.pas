unit Produto.Service;

interface

uses
  IProduto.Service,
  Produto.Model,
  IProduto.Repository,
  System.SysUtils,
  System.Generics.Collections, Validador.Contracts, Produto.Validation,
  DMConexao.infra, Produto.Repository, MeuPDV.Logger;
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
FRepository := TProdutoRepository.Create(Adm);

end;

procedure TProdutoService.Salvar(AProduto: TProduto);
var
  Validador: IValidador<TProduto>;
begin
  Validador := TProdutoValidador.Create;

  TLogger.Info('ProdutoService.Salvar',
   Format('Iniciando processo de salvamento. ID=%d | Descrição="%s"',
     [AProduto.Id, AProduto.Descricao]));

try
     TLogger.Debug('ProdutoService.Salvar', 'Executando validação do produto ' + AProduto.Id.ToString);
     Validador.Validar(AProduto);
     TLogger.Info('ProdutoService.Salvar','Validação concluída com sucesso.');

 if AProduto.Id = 0 then
 begin

   TLogger.Info('ProdutoService.Salvar','Operação identificada: Cadastro de produto');
   FRepository.Inserir(AProduto);
   TLogger.Info('ProdutoService.Salvar', 'Produto inserido com sucesso no banco de dados');

 end
 else
 begin
   TLogger.Info('ProdutoService.Salvar',
   Format('Operação identificada: Edição do produto código = %d', [AProduto.Id]));
   FRepository.Atualizar(AProduto);
 end;

 TLogger.Info('ProdutoService.Salvar','Processo de salvamento concluído com sucesso');

 except
   on E: Exception do
     begin
       TLogger.Erro('ProdutoService.Salvar',
        Format('Erro ao salvar produto. Código=%d | Descrição="%s" | Erro=%s',
        [AProduto.Id, AProduto.Descricao, E.Message] ));
       raise Exception.CreateFmt('Erro ao salvar Produto: %s', [E.Message]);
     end;
  end;
end;

procedure TProdutoService.Excluir(AId: Integer);
begin

if AId <= 0 then
begin
  TLogger.Warning('ProdutoService.Excluir','Erro: ID ' + AId.ToString + ' è inválido');
  raise Exception.Create('ID inválido');
end;


TLogger.Info('ProdutoService.Excluir','Iniciando exclusão do produto ' + AId.ToString);
FRepository.Excluir(AId);
TLogger.Info( 'ProdutoService.Excluir','Produto de código ' + AId.ToString +' excluído com sucesso');
end;

function TProdutoService.ListarProdutos: TObjectList<TProduto>;
begin
 TLogger.Debug('ProdutoService.ListarProdutos','Iniciando listagem de produtos');
 Result := FRepository.Listar;
 TLogger.Debug('ProdutoService.ListarProdutos',Format('Total de %d produtos dispóníveis no sistema', [Result.Count] ));
end;

function TProdutoService.PesquisarProdutos(
  APesquisa: String): TObjectList<TProduto>;
begin
try

  if APesquisa.Trim.IsEmpty then
  begin
    TLogger.Warning('ProdutoService.PesquisarProdutos', 'Tentativa de pesuisa com termo vazio');
    raise Exception.Create('Informe algo para pesquisar');
  end;
  TLogger.Debug('ProdutoService.PesquisarProdutos', 'Pesquisando produtos por: ' + APesquisa.Trim );
  Result := FRepository.PesquisarProdutos(APesquisa);

  if Assigned(Result) then
    TLogger.Debug('ProdutoService.PesquisarProdutos', Format('Pesquisa por "%s" retornou %d resultado(s)', [APesquisa.Trim, Result.Count]))
  else
    TLogger.Warning('ProdutoService.PesquisarProdutos', 'Pesquisa por ' + APesquisa.Trim + ' retornou nada');

except
  on E: Exception do
   begin
   TLogger.Erro('ProdutoService.PesquisarProdutos', Format('Erro ao pesquisar: %s',[E.Message]));
   raise;
   end;

end;
end;

function TProdutoService.BuscarPorId(AId: Integer): TProduto;
begin
TLogger.Debug('ProdutoService.BuscarPorId','Buscando produto pelo ID ' + AId.ToString);
Result := FRepository.BuscarPorId(AId);
end;

end.
