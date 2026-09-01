unit uProdutoService;

interface

uses
  uIProdutoService,
  uIProdutoRepository,
  System.SysUtils,
  System.Generics.Collections, uIValidador, uProdutoValidador,
  uDMConexao, uProdutoRepository, uLogger, uProdutoDTO,
  uProduto, uProdutoMapper;
type
 TProdutoService = class(TInterfacedObject, IProdutoService)

  private
    FRepository : IProdutoRepository;


  public
   constructor Create(ARepository: IProdutoRepository);
   procedure Salvar(AProdutoDTO: TProdutoDTO);
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

procedure TProdutoService.Salvar(AProdutoDTO: TProdutoDTO);
var
  Validador: IValidador<TProdutoDTO>;
  Produto: TProduto;
begin
  TLogger.Info(
    'ProdutoService.Salvar',
    Format(
      'Iniciando processo de salvamento. ID=%d | Descrição="%s"',
      [AProdutoDTO.Id, AProdutoDTO.Descricao]
    )
  );

  try
    Validador := TProdutoValidador.Create;

    TLogger.Debug(
      'ProdutoService.Salvar',
      'Executando validação do produto'
    );

    Validador.Validar(AProdutoDTO);

    TLogger.Info(
      'ProdutoService.Salvar',
      'Validação conclu�da com sucesso.'
    );

    Produto := TProdutoMapper.ConverterParaEntidade(AProdutoDTO);

    try

      if Produto.Id = 0 then
      begin
        TLogger.Info(
          'ProdutoService.Salvar',
          'Operação identificada: Cadastro de produto'
        );

        FRepository.Inserir(Produto);
        AProdutoDTO.Id := Produto.Id;
        TLogger.Info(
          'ProdutoService.Salvar',
          'Produto cadastrado com sucesso no banco de dados. ' +
          'ID gerado: ' + Produto.Id.ToString
        );
      end
      else
      begin
        TLogger.Info(
          'ProdutoService.Salvar',
          Format(
            'Operação identificada: Edição do produto código = %d',
            [Produto.Id]
          )
        );

        FRepository.Atualizar(Produto);

        TLogger.Info(
          'ProdutoService.Salvar',
          Format(
            'Produto ID=%d atualizado com sucesso.',
            [Produto.Id]
          )
        );
      end;

      TLogger.Info(
        'ProdutoService.Salvar',
        'Processo de salvamento concluído com sucesso'
      );

    finally
      Produto.Free;
    end;

  except
    on E: Exception do
    begin
      TLogger.Erro(
        'ProdutoService.Salvar',
        Format(
          'Erro ao salvar produto. Código=%d | Descrição="%s" | Erro=%s',
          [AProdutoDTO.Id, AProdutoDTO.Descricao, E.Message]));
        raise Exception.CreateFmt('Erro ao salvar Produto: %s', [E.Message]);
    end;
  end;
end;

procedure TProdutoService.Excluir(AId: Integer);
begin

if AId <= 0 then
begin
  TLogger.Warning('ProdutoService.Excluir','Erro: ID ' + AId.ToString + ' é inválido');
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
  APesquisa: String
): TObjectList<TProdutoDTO>;
var
  Termo: string;
  Produtos: TObjectList<TProduto>;
  Produto: TProduto;
begin
  try
    Termo := Trim(APesquisa);

    if Termo.IsEmpty then
    begin
      TLogger.Warning(
        'ProdutoService.PesquisarProdutos',
        'Tentativa de pesquisa com termo vazio');

      raise Exception.Create('Informe algo para pesquisar');
    end;

    TLogger.Debug(
      'ProdutoService.PesquisarProdutos',
      'Pesquisando produtos por: ' + Termo);

    Produtos := FRepository.PesquisarProdutos(Termo);

    Result := TObjectList<TProdutoDTO>.Create(True);

    try
      for Produto in Produtos do
      begin
        Result.Add(
          TProdutoMapper.ConverterParaDto(Produto)
        );
      end;

      TLogger.Debug(
        'ProdutoService.PesquisarProdutos',
        Format(
          'Pesquisa por "%s" retornou %d resultado(s)',
          [Termo, Result.Count]));

    finally
      Produtos.Free;
    end;

  except
    on E: Exception do
    begin
      TLogger.Erro(
        'ProdutoService.PesquisarProdutos',
        Format('Erro ao pesquisar: %s', [E.Message]));
      raise;
    end;
  end;
end;

function TProdutoService.BuscarPorId(AId: Integer): TProdutoDTO;
var
  Produto: TProduto;
begin
  TLogger.Debug(
    'ProdutoService.BuscarPorId',
    'Buscando produto pelo ID ' + AId.ToString);

  Produto := FRepository.BuscarPorId(AId);

  if not Assigned(Produto) then
  begin
    TLogger.Warning(
      'ProdutoService.BuscarPorId',
      'Nenhum produto encontrado para o ID ' + AId.ToString);

    Result := nil;
    Exit;
  end;

  try
    Result := TProdutoMapper.ConverterParaDto(Produto);

    TLogger.Debug(
      'ProdutoService.BuscarPorId',
      'Produto encontrado com sucesso. ID=' + AId.ToString);

  finally
    Produto.Free;
  end;
end;

end.
