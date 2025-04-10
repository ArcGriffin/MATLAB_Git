% Function to find chains of stuck particles using DFS
function chains = find_stuck_particle_chains(stuck_particles_matrix)
    num_particles = size(stuck_particles_matrix, 1);
    visited = false(1, num_particles);
    chains = cell(0);

    for i = 1:num_particles
        if ~visited(i)
            chain = dfs(stuck_particles_matrix, i, visited);
            chains{end+1} = chain;
        end
    end

    % Combine similar chains
    combined_chains = {};
    while ~isempty(chains)
        current_chain = chains{1};
        chains(1) = [];
        combined = false;
        for i = 1:length(combined_chains)
            if any(ismember(current_chain, combined_chains{i}))
                combined_chains{i} = union(current_chain, combined_chains{i});
                combined = true;
                break;
            end
        end
        if ~combined
            combined_chains{end+1} = current_chain;
        end
    end
    chains = combined_chains;
end

% DFS algorithm
function chain = dfs(stuck_particles_matrix, particle_index, visited)
    chain = [];
    stack = particle_index;

    while ~isempty(stack)
        current_particle = stack(end);
        stack(end) = [];
        if ~visited(current_particle)
            chain = [chain, current_particle];
            visited(current_particle) = true;
            connected_particles = find(stuck_particles_matrix(current_particle, :));
            stack = [stack, connected_particles];
        end
    end
end
