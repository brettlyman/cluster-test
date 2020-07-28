defmodule MyApp.App do
  use Application

  def start(_type, _args) do
    topologies = [
      example: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]
    children = [
      {Cluster.Supervisor, [topologies, [name: MyApp.ClusterSupervisor]]},
      {Task.Supervisor, name: App.Tasks}
    ]
    Supervisor.start_link(children, strategy: :one_for_one, name: MyApp.Supervisor)
  end
end
