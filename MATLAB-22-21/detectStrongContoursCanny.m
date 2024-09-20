function resultImage = detectStrongContoursCanny(binaryImage, threshold)
    % Função para detectar contornos usando Canny e inverter para fundo branco e contornos pretos
    % binaryImage: Imagem binária
    % threshold: Limiar para contornos fortes
    % resultImage: Imagem com contornos pretos em fundo branco

    % Detectar os contornos usando o filtro Canny
    edges = edge(binaryImage, 'Canny', threshold);
    
    % Inverter a imagem de contornos para que os contornos sejam pretos e fundo branco
    resultImage = edges;  % Inverte a imagem binária
end
