# Makefile for SCI Lecture Slides

# Variables
MARP = npx -y @marp-team/marp-cli
#SLIDES_MD = slides/slides-marp.md
SLIDES_MD = slides/slides.md
OUTPUT_DIR = output
OUTPUT_PPTX = $(OUTPUT_DIR)/slides.pptx
THEME_CSS = theme.css

# Default target
.PHONY: all
all: pptx

# Create output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Generate PPTX from markdown
.PHONY: pptx
pptx: $(OUTPUT_DIR)
	$(MARP) $(SLIDES_MD) --pptx -o $(OUTPUT_PPTX)
	@echo "✅ PPTX generated: $(OUTPUT_PPTX)"

# Generate PPTX with custom theme (if theme.css exists)
.PHONY: pptx-themed
pptx-themed: $(OUTPUT_DIR)
	@if [ -f $(THEME_CSS) ]; then \
		$(MARP) $(SLIDES_MD) --pptx --theme $(THEME_CSS) -o $(OUTPUT_PPTX); \
		echo "✅ PPTX generated with theme: $(OUTPUT_PPTX)"; \
	else \
		echo "⚠️  Theme file $(THEME_CSS) not found. Run 'make create-theme' first."; \
		exit 1; \
	fi

# Generate HTML preview
.PHONY: html
html: $(OUTPUT_DIR)
	$(MARP) $(SLIDES_MD) --html -o $(OUTPUT_DIR)/slides.html
	@echo "✅ HTML generated: $(OUTPUT_DIR)/slides.html"

# Watch mode for development
.PHONY: watch
watch:
	$(MARP) $(SLIDES_MD) --watch --html -o $(OUTPUT_DIR)/slides.html

# Create a basic theme CSS file
.PHONY: create-theme
create-theme:
	@echo "/* @theme sci */" > $(THEME_CSS)
	@echo "" >> $(THEME_CSS)
	@echo "section {" >> $(THEME_CSS)
	@echo "  background-color: #1d1d1d;" >> $(THEME_CSS)
	@echo "  color: #ffffff;" >> $(THEME_CSS)
	@echo "  font-family: 'Arial', sans-serif;" >> $(THEME_CSS)
	@echo "}" >> $(THEME_CSS)
	@echo "" >> $(THEME_CSS)
	@echo "section.section-header {" >> $(THEME_CSS)
	@echo "  background-color: #1d1d1d;" >> $(THEME_CSS)
	@echo "  text-align: center;" >> $(THEME_CSS)
	@echo "  justify-content: center;" >> $(THEME_CSS)
	@echo "}" >> $(THEME_CSS)
	@echo "✅ Theme file created: $(THEME_CSS)"
	@echo "📝 Edit this file to customize colors, fonts, etc."

# Clean generated files
.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)
	@echo "🧹 Cleaned output directory"

# Help
.PHONY: help
help:
	@echo "SCI Lecture Slides Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make pptx         - Generate PPTX from markdown"
	@echo "  make pptx-themed  - Generate PPTX with custom theme"
	@echo "  make html         - Generate HTML preview"
	@echo "  make watch        - Watch mode for development"
	@echo "  make create-theme - Create a basic theme.css file"
	@echo "  make clean        - Remove generated files"
	@echo ""
	@echo "⚠️  Note: Marp uses CSS themes, not PPTX templates"
