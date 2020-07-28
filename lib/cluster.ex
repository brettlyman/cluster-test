defmodule Cluster do
  use Application
  
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    topologies = [
      test: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: Cluster.ClusterSupervisor]]}
    ]
    opts = [strategy: :one_for_one, name: Cluster.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
