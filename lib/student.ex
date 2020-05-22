defmodule Student do
  use GenServer

  @spec new(String.t()) :: :ignore | {:error, any} | {:ok, pid}
  def new(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def name(student) when is_pid(student) do
    try do
      {:ok, GenServer.call(student, :name)}
    catch
      :exit, {:noproc, _} -> {:error, :noproc}
      :exit, {:normal, _} -> {:error, :normal}
    end
  end

  def name(_student) do
    {:error, :not_student}
  end

  def projects(student) when is_pid(student) do
    try do
      {:ok, GenServer.call(student, :projects)}
    catch
      :exit, {:noraml, _} -> {:error, :noraml}
      :exit, {:noproc, _} -> {:error, :noproc}
    end
  end

  def projects(_student) do
    {:error, :not_student}
  end

  @impl true
  @spec init(String.t()) :: {:ok, %{name: String.t(), projects: []}}
  def init(name) do
    {:ok, %{name: name, projects: []}}
  end

  @impl true
  def handle_call(:name, _from, state) do
    {:reply, state[:name], state}
  end

  @impl true
  def handle_call(:projects, _from, state) do
    {:reply, state[:projects], state}
  end
end
