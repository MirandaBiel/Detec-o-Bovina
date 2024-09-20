function numVacas = detectarEContarVacas(binaryImage, cannyThreshold)
    % Função completa para detectar e contar vacas em uma imagem
    % binaryImage: Imagem binária a ser processada
    % cannyThreshold: Limiar para o detector Canny ([limiarInferior, limiarSuperior])
    % numVacas: Número de vacas detectadas

    % Passo 1: Detectar bordas usando o filtro Canny
    if nargin < 2
        cannyThreshold = [0.05, 0.2]; % Se o limiar não for informado, usar valores padrão
    end
    edges = edge(binaryImage, 'Canny', cannyThreshold);

    % Exibir bordas detectadas pelo Canny
    figure;
    imshow(edges);
    title('Bordas Detectadas com Canny');

    % Passo 2: Inverter a imagem de bordas (fundo branco, bordas pretas)
    invertedEdges = ~edges;

    % Exibir imagem de bordas invertida
    figure;
    imshow(invertedEdges);
    title('Bordas Invertidas (Fundo Branco, Bordas Pretas)');

    % Passo 3: Preencher áreas internas (fechar buracos nas bordas)
    filledImage = imfill(invertedEdges, 'holes');

    % Exibir imagem com áreas preenchidas
    figure;
    imshow(filledImage);
    title('Imagem com Áreas Preenchidas');

    % Passo 4: Remover objetos pequenos (ruído) que não sejam vacas
    cleanImage = bwareaopen(filledImage, 100);

    % Exibir imagem limpa (sem objetos pequenos)
    figure;
    imshow(cleanImage);
    title('Imagem Limpa (Ruído Removido)');

    % Passo 5: Rotular as regiões conectadas (vacas)
    [labeledImage, numVacas] = bwlabel(cleanImage);

    % Exibir a imagem com as vacas rotuladas (coloridas)
    figure;
    imshow(label2rgb(labeledImage, 'jet', 'k', 'shuffle'));
    title(['Número de vacas detectadas: ', num2str(numVacas)]);
end
