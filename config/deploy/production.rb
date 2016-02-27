role :app, %w{neurones@37.139.21.61:77}
role :web, %w{neurones@37.139.21.61:77}
role :db,  %w{neurones@37.139.21.61:77}

# Define server(s)
server '37.139.21.61:77', user: 'neurones', roles: %w{web app db}, primary: true

# SSH Options
# See the example commented out section in the file
# for more options.
set :ssh_options, {
    forward_agent: true,
    user: 'neurones',
    port: 77
}
