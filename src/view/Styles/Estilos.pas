unit Estilos;

interface

uses Vcl.Graphics;

const
  // Cores Principais (Identidade Visual em Azul)
  COR_PRIMARIA_AZUL      = $00A5612E;  // Azul Royal/Marinho (RGB: 46, 97, 165)
  COR_CABECALHO_AZUL     = $008A4D22;  // Tom de azul mais escuro para o topo (RGB: 34, 77, 138)

  // Cores de Fundo (Backgrounds)
  COR_FUNDO_CLARO        = $00FBF9F8;  // Fundo cinza bem claro (fundo da aplicação)
  COR_FUNDO_BRANCO       = $00FFFFFF;  // Fundo de cards, painéis e tabelas

  // Tipografia (Textos)
  COR_TEXTO_ESCURO       = $003D332D;  // Texto principal (quase preto)
  COR_TEXTO_CINZA        = $009B8E85;  // Texto secundário/labels/placeholders
  COR_TEXTO_BRANCO       = $00FFFFFF;  // Texto sobre fundos escuros

  // Elementos de UI (Bordas e Ícones)
  COR_BORDA              = $00E9E3DF;  // Linhas divisórias e bordas de inputs
  COR_ICONE_AZUL         = $00A5612E;  // Cor padrão para ícones de ação (mesmo azul primário)

  // Status (Semântica)
  COR_STATUS_ATIVO_FUNDO    = $00E1F4E8; // Fundo verde claro (Sucesso)
  COR_STATUS_ATIVO_TEXTO    = $0057B97A; // Texto verde (Sucesso)
  COR_STATUS_INATIVO_FUNDO  = $00E7E8FF; // Fundo vermelho/rosa claro (Erro/Inativo)
  COR_STATUS_INATIVO_TEXTO  = $00737BFF; // Texto vermelho (Erro/Inativo)

implementation

end.
