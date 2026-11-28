function slug(text) {
  let name = text.split("/").pop() || "";

  try {
    name = decodeURIComponent(name);
  } catch {}

  name = name
    .replace(/[^a-zA-Z0-9+._?=-]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .toLowerCase();

  return name === "." || name === ".." ? "" : name;
}

function apply(template, substitutions) {
  if (!template || !substitutions) return template;

  let replaced = template;

  for (const [i, sub] of substitutions.entries())
    replaced = replaced.replace(new RegExp(`\\{${i}\\}`, "g"), sub);

  return replaced;
}

module.exports = {
  slug,
  apply
}
