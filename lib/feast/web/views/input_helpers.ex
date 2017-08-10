defmodule Feast.Web.InputHelpers do
  @moduledoc ~S"""
  Helpers for making forms in an elegant and easy way.
  """

  use Phoenix.HTML

  # DEPRECATED, use form_input for clarity
  # TODO remove
  def input(form, field, opts \\ []) do
    form_input(form, field, opts)
  end

  @doc ~S"""
  Creates an input with the right wrappers and labels so we can have
  a consistent design, and create forms faster and more reliably.

      <%= form_input f, :name %>
      Creates an input with id #name of type determined by the form provided. If the form has a field called name that is of type text, the input will be text.

      <%= form_input f, :name, using: "number" %>
      You can override the type with the 'using' keyword.
  """
  def form_input(form, field, opts \\ []) do
    # finds the type of input we are dealing with
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    # Get a state class like error
    current_state = state_class(form, field)

    # Options for the the "field" div which wraps the input
    wrapper_opts = [class: "field #{current_state}"]

    # Options for all labels
    label_opts = []

    # Default to required. This might be a bad idea.
    # TODO BUG This does not work whyyyy
    required = if (:required in opts && !opts[:required]), do: [], else: [required: true]
    # Options for all inputs, and add the custom ones for this specific input
    input_opts = required ++ opts

    # the actual input
    input = input(type, form, field, input_opts)
    label = label(form, field, humanize(field), label_opts)
    # Has a nice animation
    bar = span([class: "bar"])
    # An error tag, or not
    error = Feast.Web.ErrorHelpers.error_tag(form, field) || ""

    content_tag :div, wrapper_opts do
      [input, bar, label, error]
    end
  end

  @doc ~S"""
  Creates an select in the same design as input, but takes a list of options in addition.

  !!! Remember the _id part, you are selecting between the ids of the categories.

      <%= form_select f, :category_id, elements_to_select_from %>
      A select for category, that takes a list of category elements
      to choose form
  """
  def form_select(form, field, select_options) do
    # Get a state class like error
    current_state = state_class(form, field)

    # Options for the the "field" div which wraps the input
    wrapper_opts = [class: "field #{current_state}"]

    # the actual input
    select_el = select(form, field, select_options)

    label = label(form, field, humanize(field))

    # An error tag, or not
    error = Feast.Web.ErrorHelpers.error_tag(form, field) || ""

    content_tag :div, wrapper_opts do
      [select_el, label, error]
    end
  end

  @doc ~S"""
  Creates a message element with an error message if there are
  errors in the form.

      <%= form_errors @changeset %>
      Creates a message only if there are errors
  """
  def form_errors(changeset) do
    if changeset.action do
      wrapper_opts = [class: "ui danger message"]

      content_tag :div, wrapper_opts do
        content_tag(:p, "Oops, something went wrong! Please check the errors below.")
      end
    end
  end

  @doc ~S"""
  Creates a nice submit button for the form

      <%= form_submit "Submit message here" %>
      Creates a submit button with a message
  """
  def form_submit(label) do
    wrapper_opts = [class: "field"]

    content_tag :div, wrapper_opts do
      submit(label, class: "ui submit green button")
    end
  end

  defp state_class(form, field) do
    cond do
      !form.source.action -> ""
      form.errors[field] -> "error"
      true -> "success"
    end
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end

  defp span(opts) do
    content_tag(:span, "", opts)
  end
end