unit Produto.Service;

interface

uses
  IProduto.Service,
  IProduto.Repository,
  System.SysUtils,
  System.Generics.Collections, Validador.Contracts, Produto.Validation,
  DMConexao.infra, Produto.Repository, MeuPDV.Logger, Produto.DTO,
  Produto.Model, Produto.Mapper;
type
 TProdutoService = class(TInterfacedObject, IProdutoService)

  private
    FRepository : IProdutoRepository;


  public
   constructor Create(ARepository: IProdutoRepository);
   procedure Salvar(AProduto: TProdutoDTO);
   procedure Excluir(AId : Integer);
   function ListarProdutos : TObjectList<TProdutoDTO>;
   function BuscarPorId(AId: Integer) : TProdutoDTO;
   function PesquisarProdutos(APesquisa: String): TObjectList<TProdutoDTO>;

 end;

implementation

{ TProdutoService }

constructor TProdutoService.Create(ARepository: IProdutoRepository);
begin
FRepository := ARepository;

end;

procedure TProdutoService.Salvar(AProduto: TProdutoDTO);
var
  Validador: IValidador<TProdutoDTO>;
  Produto : TProduto;
begin
  Validador := TProdutoValidador.Create;
  Produto := TProduto.Create;

  TLogger.Info('ProdutoService.Salvar',
   Format('Iniciando processo de salvamento. ID=%d | Descrição="%s"',
     [AProduto.Id, AProduto.Descricao]));

try
   Produto.Id := AProduto.Id;
   Produto.Descricao := AProduto.Descricao;




     TLogger.Debug('ProdutoService.Salvar', 'Executando validação do produto ');
     Validador.Validar(AProduto);
     TLogger.Info('ProdutoService.Salvar','Validação concluída com sucesso.');

 if AProduto.Id = 0 then
 begin

   TLogger.Info('ProdutoService.Salvar','Operação identificada: Cadastro de produto');
   FRepository.Inserir(Produto);
   TLogger.Info('ProdutoService.Salvar', 'Produto cadastrado com sucesso no banco de dados. ' +
   'ID gerado: ' + AProduto.Id.ToString);

 end
 else
 begin
   TLogger.Info('ProdutoService.Salvar',
   Format('Operação identificada: Edição do produto código = %d', [AProduto.Id]));
   FRepository.Atualizar(Produto);
   TLogger.Info('ProdutoService.Salvar',
   Format('Produto ID=%d atualizado com sucesso.', [AProduto.Id]));

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

function TProdutoService.ListarProdutos: TObjectList<TProdutoDTO>;
var
  Produtos: TObjectList<TProduto>;
  Produto: TProduto;
begin
  TLogger.Debug(
    'ProdutoService.ListarProdutos',
    'Iniciando listagem de produtos'
  );

  Produtos := FRepository.Listar;

  Result := TObjectList<TProdutoDTO>.Create(True);

  try
    for Produto in Produtos do
    begin
      Result.Add(
        TProdutoMapper.ConverterParaDto(Produto)
      );
    end;

    TLogger.Debug(
      'ProdutoService.ListarProdutos',
      Format(
        'Total de %d produtos disponíveis no sistema',
        [Result.Count]));

  finally
    Produtos.Free;
  end;
end;
function TProdutoService.PesquisarProdutos(
  APesquisa: String): TObjectList<TProdutoDTO>;
Var
  Termo: string;
  Produto: TProduto;
  ProdutoDTO: TProdutoDTO;

begin

  try
    Termo := Trim(APesquisa);



  if Termo.IsEmpty then
  begin
    TLogger.Warning('ProdutoService.PesquisarProdutos', 'Tentativa de pesuisa com termo vazio');
    raise Exception.Create('Informe algo para pesquisar');
  end;
  TLogger.Debug('ProdutoService.PesquisarProdutos', 'Pesquisando produtos por: ' + Termo );
  Result := FRepository.PesquisarProdutos(Termo);

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
