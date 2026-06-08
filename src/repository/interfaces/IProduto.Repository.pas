unit IProduto.Repository;

interface

uses Produto.Model, System.Generics.Collections;

type
IProdutoRepository = interface
  ['{526990B0-9A39-4C8B-86B4-197B0B7EEDBB}']

  procedure Inserir(AProduto: TProduto);
  procedure Atualizar(AProduto : TProduto);
  procedure Excluir(AId : Integer);
  function Listar: TObjectList<TProduto>;
  function BuscarPorId(AId: Integer): TProduto;
  function PesquisarProdutos(APesquisa: String): TObjectList<TProduto>;
end;

implementation

end.
