% Melhorias são bem-vindas 

% O jogo não roda no octave

% COMANDOS: 
%           Movimento:.......... setas do teclado
%           Sair:............... q
%           Aumentar velocidade: m
%           Diminuir velocidade: l

function [] = jogo()
close all
whitebg([0 0 0])

time    = 1;   % Velocidade da cobrinha. vai de 0 a 1.
sentido = 'N'; % Norte
limX    = 20;  % Limite do tabuleiro
limY    = 20;  % Limite do tabuleiro
exit    = 0;   % 0->Continua no programa | 1->Sai do programa

food  = [randi([1 limX]); randi([1 limY])]; % Comidinha aleatória
snake = [round(limX/2); round(limY/2)];     % 1 linha -> linhas (X)
                                            % 2 linha -> colunas(Y)

figure('KeyPressFcn',@my_callback);
    function my_callback(~,event)
        switch event.Character
            case 30
                sentido = 'N';
            case 31
                sentido = 'S';
            case 28
                sentido = 'O';
            case 29
                sentido = 'L';
            case 'q'
                exit = 1;           
            case 'm'
                if time > 1/10
                    time = time - 1/10;
                end
            case 'l'
                if time < 1
                    time = time + 1/10;
                end                
        end
    end


while exit == 0
    
    pause(time)                                     
    last_pos = [snake(1,1); snake(2,1)];
    snake = movimenta(sentido, snake, limX, limY);
    
    if snake(1, 1) == food(1, 1) && snake(2, 1) == food(2, 1)
        % Comidinha troca de posição
        food  = [randi([1 limX]); randi([1 limY])]; 
        snake(:, end+1) = last_pos;
    end
    
    % Plota a cobrinha
    drawSnake(snake, food, limX, limY)              
end

close all

end
function [] = drawSnake(snake, food, limX, limY)

    % Plota comidinha e a cobrinha
    plot(food(1, 1), food(2, 1), 'go', snake(1, :), snake(2, :), 'ro') 
    % Ajusta os eixos do gráfico
    axis([0 limX 0 limY])                                                     
end
function [snake] = movimenta(sentido, snake, limX, limY)

% 1 linha -> linhas (X)
% 2 linha -> colunas(Y)

aux = snake;

% Mantem a cobrinha caminhando
switch sentido                                                         
    case 'N'
        snake(2,1) = snake(2,1) + 1;
        if snake(2,1) > limY
            snake(2,1) = 0;
        end
    case 'S'
        snake(2,1) = snake(2,1) - 1;
        if snake(2,1) < 0
            snake(2,1) = limY;
        end
    case 'O'
        snake(1,1) = snake(1,1) - 1;
        if snake(1,1) < 0
            snake(1,1) = limX;
        end
    case 'L'
        snake(1,1) = snake(1,1) + 1;
        if snake(1,1) > limX
            snake(1,1) = 0;
        end
end

if size(snake, 2) > 1
    snake(:, 2:end) = aux(:, 1:end-1)
end
end
































