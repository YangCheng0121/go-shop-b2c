package helpers

import "errors"

// Pagination represents a set of results of pagination calculations.
type Pagination struct {
	List       interface{} `json:"list"`
	Total      int         `json:"total"`
	PageSize   int         `json:"page_size"`
	PageNumber int         `json:"page_number"`
	IsFirst    bool        `json:"is_first"`
	IsLast     bool        `json:"is_last"`
}

// New initialize a new pagination calculation and returns a Pagination as result.
func NewPagination(list interface{}, total int, pageSize int, pageNumber int) (p *Pagination, err error) {
	if pageSize <= 0 {
		return nil, errors.New("PageSize Should Not Less than 0")
	}
	if pageNumber <= 0 {
		return nil, errors.New("PageNumber Should Not Less than 0")
	}

	p = &Pagination{list, total, pageSize, pageNumber, false, false}

	p.IsFirst = p.isFirst()
	p.IsLast = p.isLast()

	if p.PageNumber > p.TotalPages() {
		p.PageNumber = p.TotalPages()
	}
	return p, nil
}

// IsFirst returns true if PageNumber page is the first page.
func (p *Pagination) isFirst() bool {
	return p.PageNumber == 1
}

// HasPrevious returns true if there is a previous page relative to PageNumber page.
func (p *Pagination) HasPrevious() bool {
	return p.PageNumber > 1
}

func (p *Pagination) Previous() int {
	if !p.HasPrevious() {
		return p.PageNumber
	}
	return p.PageNumber - 1
}

// HasNext returns true if there is a next page relative to PageNumber page.
func (p *Pagination) HasNext() bool {
	return p.Total > p.PageNumber*p.PageSize
}

func (p *Pagination) Next() int {
	if !p.HasNext() {
		return p.PageNumber
	}
	return p.PageNumber + 1
}

// IsLast returns true if PageNumber page is the last page.
func (p *Pagination) isLast() bool {
	if p.Total == 0 {
		return true
	}
	return p.Total > (p.PageNumber-1)*p.PageSize && !p.HasNext()
}

// TotalPage returns number of Total pages.
func (p *Pagination) TotalPages() int {
	if p.Total == 0 {
		return 1
	}
	if p.Total%p.PageSize == 0 {
		return p.Total / p.PageSize
	}
	return p.Total/p.PageSize + 1
}
