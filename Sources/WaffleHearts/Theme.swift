//
//  File.swift
//  
//
//  Created by Chris Jensen on 1/2/21.
//

import Foundation
import Publish
import Plot

extension Theme where Site == WaffleHearts {
    static var basic: Self {
        Theme<WaffleHearts>(
            htmlFactory: WaffleHeartsHTMLFactory(),
            resourcePaths: ["Resources/WaffleHeartsTheme/styles.css"]
        )
    }
}

private struct WaffleHeartsHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<WaffleHearts>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .wrapper(
                    .id("container"),
                    .wrapper(
                        .id("content-area"),
                        .header(for: context, selectedSection: nil),
                        .wrapper(
                            .id("content"),
                            // <---- custom content start
                            .itemList(
                                for: context.allItems(
                                    sortedBy: \.date,
                                    order: .descending
                                ),
                                on: context.site
                            )
                            // <---- content end
                        ),
                        .footer(for: context.site)
                    )
                )
            )
        )
    }

    func makeSectionHTML(for section: Section<WaffleHearts>,
                         context: PublishingContext<WaffleHearts>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .wrapper(
                    .id("container"),
                    .wrapper(
                        .id("content-area"),
                        .header(for: context, selectedSection: nil),
                        .wrapper(
                            .id("content"),
                            // <---- custom content start
                            .sectionItemList(for: section, with: context)
                            // <---- content end
                        ),
                        .footer(for: context.site)
                    )
                )
            )
        )
    }

    func makeItemHTML(
        for item: Item<WaffleHearts>,
        context: PublishingContext<WaffleHearts>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .wrapper(
                    .id("container"),
                    .wrapper(
                        .id("content-area"),
                        .header(for: context, selectedSection: item.sectionID),
                        .wrapper(
                            .id("content"),
                            // <---- custom content start
                            .article(
                                .img(.src(item.imagePath ?? "")),
                                .h2("\(item.title)"),
                                .contentBody(item.body),
                                .tagList(for: item, on: context.site)
                            )
                            // <---- content end
                        ),
                        .footer(for: context.site)
                    )
                )
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<WaffleHearts>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .wrapper(
                    .id("container"),
                    .wrapper(
                        .id("content-area"),
                        .header(for: context, selectedSection: nil),
                        .wrapper(
                            .id("content"),
                            // <---- custom content start
                            .wrapper(.contentBody(page.body))
                            // <---- content end
                        ),
                        .footer(for: context.site)
                    )
                )
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<WaffleHearts>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .wrapper(
                    .id("container"),
                    .wrapper(
                        .id("content-area"),
                        .header(for: context, selectedSection: nil),
                        .wrapper(
                            .id("content"),
                            // <---- custom content start
                            .h2("Tags"),
                            .ul(
                                .class("all-tags"),
                                .forEach(page.tags.sorted()) { tag in
                                    .li(
                                        .class("tag"),
                                        .a(
                                            .href(context.site.path(for: tag)),
                                            .text(tag.string)
                                        )
                                    )
                                }
                            )
                            // <---- content end
                        ),
                        .footer(for: context.site)
                    )
                )
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<WaffleHearts>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .wrapper(
                    .id("container"),
                    .wrapper(
                        .id("content-area"),
                        .header(for: context, selectedSection: nil),
                        .wrapper(
                            .id("content"),
                            // <---- custom content start
                            .h2(
                                "Everything tagged with ",
                                .span(.class("tag"), .text(page.tag.string))
                            ),
                            .a(
                                .class("browse-all"),
                                .text("Full list of tags"),
                                .href(context.site.tagListPath)
                            ),
                            .hr(),
                            .itemList(
                                for: context.items(
                                    taggedWith: page.tag,
                                    sortedBy: \.date,
                                    order: .descending
                                ),
                               on: context.site
                            )
                            // <---- content end
                        ),
                        .footer(for: context.site)
                    )
                )
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .id("header"),
                .h1(
                    .a(
                        .href("/"),
                        .text("Waffle Hearts")
                    )
                )
            ),
            .nav(
                .id("hamnav"),
                .label(
                    .for("hamburger"),
                    .text("&#9776;")
                ),
                .input(
                    .id("hamburger"),
                    .type(.checkbox)
                ),
                .div(
                    .id("hamitems"),
                    .forEach(sectionIDs) { section in
                        .a(
                            .href(context.sections[section].path),
                            .text(adjustedTitle(context.sections[section].title))
                        )
                    },
                    .a(
                        .href("/tags"),
                        .text("Tags")
                    ),
                    .form(
                        .method(.get),
                        .id("search-form"),
                        .attribute(named: "autocomplete", value: "off"),
                        .action("https://duckduckgo.com/"),
                        .input(
                            .type(.hidden),
                            .name("sites"),
                            .value("wafflehearts.com")
                        ),
                        .input(
                            .class("search"),
                            .type(.text),
                            .name("q"),
                            .attribute(named: "size", value: "15"),
                            .placeholder("Search")
                        ),
                        .input(
                            .type(.submit),
                            .value("Search"),
                            .attribute(named: "style", value: "visibility: hidden; display: none;")
                        )
                    )
                )
            )
        )
    }

    static func adjustedTitle(_ title: String) -> String {
        guard title == "Howto" else {
            return title
        }
        return "How To"
    }

    static func sectionItemList(
        for section: Section<WaffleHearts>,
        with context: PublishingContext<WaffleHearts>
    ) -> Node {
        return .itemList(
            for: section.items,
               on: context.site
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(
                    .wrapper(
                        .if(item.imagePath != nil,
                            .a(
                                .class("align-left"),
                                .href(item.path),
                                .img(.src(item.imagePath!))
                            )
                        ),
                        .h2(
                            .a(
                                .href(item.path),
                                .text(item.title)
                            )
                        ),
                        .p(.text(item.description)),
                        .tagList(for: item, on: site)
                    ),
                    .hr()
                )
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(
            .id("tag-list"), .forEach(item.tags) { tag in
                .li(
                    .a(
                        .href(site.path(for: tag)),
                        .text(tag.string)
                    )
                )
            }
        )
    }

    static func footer<T: Website>(for site: T) -> Node {
        let currentYear = Calendar.current.component(.year, from: Date())
        return .footer(
            .hr(),
            .p(
                .text("Created using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                ),
                .text(", "),
                .a(
                    .text("RSS feed"),
                    .href("/feed.rss")
                )
            ),
            .p(
                .b("© 2011 - \(currentYear) Anne (Beaubien) Jensen"),
                .text("  All Rights Reserved.")
            )
        )
    }
}
