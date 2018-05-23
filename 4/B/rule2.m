function v2=rule2(n,boid,zor,fov,k,vM)
% RULE2: function that calculates the effect of Rule 2: boids try to keep 
% certain distance with their neighbors
%
% INPUTS:
% n     = number of boids
% boids = boids position and velocity
% zor   = (circular) zone of repulsion  / minimum distance (see below)
% fov   = angle (in radians) of the boid field of view
% k     = number of nearest boids
% vM    = string with the vision mode
%
% OUTPUTS:
% v2    = correction of the velocity for rule 2
% 
% Xing Jin and Javier Lobato, created on 2018/04/03
% Javier Lobato, last modified on 2018/04/15

% Preallocation of the output matrix
v2 = zeros(n,2);

% Preallocate space for the boids that are inside the field of view
fovInd = zeros([length(boid),1]);
fovCount = 1;

% Loop over n boids
for i = 1:n
    % Copy the position of all boids
    tem = boid(:,1:2);
    % Instead of erasing the row of the current i-th boid, a comparison
    % inside the loop will be done. This is done in order to mantain the
    % indexes of the original matrix the same
    % Get the current i-th boid
    bi = boid(i,1:2);
    % Loop over the other n-1 boids for zor, fov and zf
    for j = 1:n
        if j ~= i
            % Store the relative position vector between boid j and boid i
            dis = tem(j,:) - bi;
            switch vM
                case 'zor'
                    % If the modulus of the distance is smaller than the 
                    % specified radius 
                    if abs(norm(dis)) < zor 
                        % Repel the i-th bird with respect the j-th bird 
                        % and accumulate the consecutive repulsion of all 
                        % the n-1 birds
                        v2(i,1:2) = v2(i,1:2) - dis;
                    end
                case 'fov'
                    % If the angle is included within the field of vision
                    if acos(dot(dis,boid(i,3:4))/(norm(dis)*norm(boid(i,3:4)))) < fov/2
                        % Repel the i-th bird with respect the j-th bird 
                        % and accumulate the consecutive repulsion of all 
                        % the n-1 birds
                        v2(i,1:2) = v2(i,1:2) - dis;
                    end
                case 'kn'
                    % Do nothing inside this for loop
                case 'zf'
                    % If the modulus of the distance is smaller than the 
                    % specified radius and the angle is included within the 
                    % field of vision
                    if abs(norm(dis)) < zor && acos(dot(dis,boid(i,3:4))/(norm(dis)*norm(boid(i,3:4)))) < fov/2
                        % Repel the i-th bird with respect the j-th bird 
                        % and accumulate the consecutive repulsion of all 
                        % the n-1 birds
                        v2(i,1:2) = v2(i,1:2) - dis;
                    end
                case 'fk'
                    % If the angle is included within the field of vision
                        if acos(dot(dis,boid(i,3:4))/(norm(dis)*norm(boid(i,3:4)))) < fov/2
                            % Just save the birds that are inside fov
                            fovInd(fovCount) = j;
                            fovCount = fovCount + 1;
                        end
                otherwise
                    error('Bad vision mode selection')
            end
        end
    end
    % Remove the zeros of the preallocated matrix
    fovInd = fovInd(1:fovCount-1);
    % Don't enter the loop if there is no birds in the field of view
    if sum(fovInd) ~= -2
        switch vM
            case 'zor'
                % Everything done
            case 'fov'
                % Everything done
            case 'kn'
                disXY = boid(:,1:2) - boid(i,1:2);
                dist = sqrt(disXY(:,1).^2+disXY(:,2).^2);
                [~,I] = sort(dist);
                % ind will have a distance of zero so let's remove it
                for j=1:length(I)
                    dis = tem(I(j),:) - bi;
                    % Given that these modes can't be combined with zone of
                    % repulsion, that input value will be used as the minimum
                    % distance between boids
                    if norm(dis) < zor
                        v2(i,1:2) = v2(i,1:2) - dis;
                    end
                end    
            case 'zf'
                % Everything done
            case 'fk'
                % If field of view is also used, only the birds inside of 
                % it will be considered to compute the closest ones
                disXY = boid(fovInd,1:2) - boid(i,1:2);
                dist = sqrt(disXY(:,1).^2+disXY(:,2).^2);
                [~,I] = sort(dist);
                I = fovInd(I);
                if k > length(I)
                    I = I(1:length(I));
                else 
                    I = I(1:k);
                end
                for j=1:length(I)
                    dis = tem(I(j),:) - bi;
                    % Given that these modes can't be combined with zone of
                    % repulsion, that input value will be used as the minimum
                    % distance between boids
                    if norm(dis) < zor
                        v2(i,1:2) = v2(i,1:2) - dis;
                    end
                end    
            otherwise
                error('Bad vision mode selection')
        end
    end
end
    
end
