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
   TLogger.Info('ProdutoService.Salvar',
   Format('Operação identificada: Edição do produto código = %d', [AProduto.Id]));
   FRepository.Atualizar(AProduto);

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
  TLogger.Erro('ProdutoService','Erro: ID ' + AId.ToString + ' è inválido');
  raise Exception.Create('ID inválido');
end;

FRepository.Excluir(AId);
TLogger.Info( 'ProdutoService','Produto de código ' + AId.ToString +' excluído com sucesso');
end;

function TProdutoService.ListarProdutos: TObjectList<TProduto>;
begin
 Result := FRepository.Listar;
end;

function TProdutoService.PesquisarProdutos(
  APesquisa: String): TObjectList<TProduto>;
begin
  if APesquisa.Trim.IsEmpty then
  begin
    TLogger.Erro('ProdutoService', 'Tentativa de pesuisa com termo vazio');
    raise Exception.Create('Informe algo para pesquisar');
  end;
  TLogger.Info('ProdutoService', 'Pesquisando produtos por: ' + APesquisa.Trim );
  Result := FRepository.PesquisarProdutos(APesquisa);

  if Result <> nil then
    TLogger.Info('ProdutoService', Format('Pesquisa por "%s" retornou %d resultado(s)', [APesquisa.Trim, Result.Count]))
  else
    TLogger.Info('ProdutoService', 'Pesquisa por ' + APesquisa.Trim + 'retornou nada');
end;

function TProdutoService.BuscarPorId(AId: Integer): TProduto;
begin
Result := FRepository.BuscarPorId(AId);
end;

end.
