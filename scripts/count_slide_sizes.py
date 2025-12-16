#!/usr/bin/env python3
"""Count characters between slide separators (---) in markdown files."""

from pathlib import Path

def count_slide_sizes(file_path):
    """Count and display character counts for each slide."""
    content = Path(file_path).read_text()

    # Split by slide separator
    slides = content.split('---')

    print(f"Total slides: {len(slides)}\n")
    print(f"{'Slide #':<10} {'Characters':<15} {'Preview'}")
    print("-" * 70)

    for i, slide in enumerate(slides, 1):
        char_count = len(slide)
        # Get first line (usually the title) for preview
        first_line = slide.strip().split('\n')[0] if slide.strip() else ""
        preview = first_line[:50] + "..." if len(first_line) > 50 else first_line

        print(f"{i:<10} {char_count:<15} {preview}")

if __name__ == "__main__":
    slides_file = "slides/slides.md"
    count_slide_sizes(slides_file)
